import Foundation
import Darwin.C
import SwiftSyntax
import Progress
import Rainbow

extension Notification.Name {
    static let muterLaunched = Notification.Name("muterLaunched")
    static let projectCopyStarted = Notification.Name("projectCopyStarted")
    static let projectCopyFinished = Notification.Name("projectCopyFinished")

    static let workingDirectoryCreated = Notification.Name("workingDirectoryCreated")

    static let sourceFileDiscoveryStarted = Notification.Name("sourceFileDiscoveryStarted")
    static let sourceFileDiscoveryFinished = Notification.Name("sourceFileDiscoveryFinished")

    static let mutationPointDiscoveryStarted = Notification.Name("mutationPointDiscoveryStarted")
    static let mutationPointDiscoveryFinished = Notification.Name("mutationPointDiscoveryFinished")

    static let mutationTestingStarted = Notification.Name("mutationTestingStarted")
    static let mutationTestingFinished = Notification.Name("mutationTestingFinished")

    static let newMutationTestOutcomeAvailable = Notification.Name("newMutationTestOutcomeAvailable")
    static let newTestLogAvailable = Notification.Name("newTestLogAvailable")

    static let configurationFileCreated = Notification.Name("configurationFileCreated")
}

func flushStdOut() {
    fflush(stdout)
}

final class RunCommandObserver {
    private let reporter: Reporter
    private let fileManager: FileSystemManager
    private let loggingDirectory: String
    private let flushStdOut: () -> Void
    private var progressBar: ProgressBar!
    private var numberOfMutationPoints: Int!
    private let notificationCenter: NotificationCenter = .default
    private var notificationHandlerMappings: [(name: Notification.Name, handler: (Notification) -> Void)] {
       return [
            (name: .muterLaunched, handler: handleMuterLaunched),
            
            (name: .projectCopyStarted, handler: handleProjectCopyStarted),
            (name: .projectCopyFinished, handler: handleProjectCopyFinished),
            
            (name: .sourceFileDiscoveryStarted, handler: handleSourceFileDiscoveryStarted),
            (name: .sourceFileDiscoveryFinished, handler: handleSourceFileDiscoveryFinished),
            
            (name: .mutationPointDiscoveryStarted, handler: handleMutationPointDiscoveryStarted),
            (name: .mutationPointDiscoveryFinished, handler: handleMutationPointDiscoveryFinished),
            
            (name: .mutationTestingStarted, handler: handleMutationTestingStarted),

            (name: .newMutationTestOutcomeAvailable, handler: handleNewMutationTestOutcomeAvailable),
            (name: .newTestLogAvailable, handler: handleNewTestLogAvailable),

            (name: .mutationTestingFinished, handler: handleMutationTestingFinished),
       ]
    }
    
    init(reporter: Reporter, fileManager: FileSystemManager, flushHandler: @escaping () -> Void) {
        self.reporter = reporter
        self.fileManager = fileManager
        self.flushStdOut = flushHandler
        self.loggingDirectory = createLoggingDirectory(in: fileManager.currentDirectoryPath, fileManager: fileManager)

        for (name, handler) in notificationHandlerMappings {
            notificationCenter.addObserver(forName: name, object: nil, queue: nil, using: handler)
        }
    }

    deinit {
        notificationCenter.removeObserver(self)
    }
}

extension RunCommandObserver {
    func handleMuterLaunched(notification: Notification) {
        if reporter == .plainText {
            printHeader()
        }
    }
    
    func handleProjectCopyStarted(notification: Notification) {
        if reporter == .plainText {
            print("Copying your project to a temporary directory for testing...")
        }
    }

    func handleProjectCopyFinished(notification: Notification) {
        if reporter != .json {
            print("Finished copying your project to a temporary directory for mutation testing")
            print("\nYou can find your copied project here:\n\n\(String(describing: notification.object!).bold)")
            print("\nThis directory will also serve as a backup for any XCTest logs that are generated by running your test suite")
        }
    }

    func handleSourceFileDiscoveryStarted(notification: Notification) {
        if reporter == .plainText {
            printMessage("Discovering Swift files which Muter will analyze...")
        }
    }

    func handleSourceFileDiscoveryFinished(notification: Notification) {
        if reporter == .plainText {
            let discoveredFilePaths = notification.object as! [String]
            let fileNames = discoveredFilePaths.map(URL.init(fileURLWithPath:)).map { $0.lastPathComponent }.joined(separator: "\n").bold
            print("In total, Muter discovered \(discoveredFilePaths.count) Swift files\n\n\(fileNames)")
        }
    }

    func handleMutationPointDiscoveryStarted(notification: Notification) {
        if reporter == .plainText {
            printMessage("Analyzing source files to find mutants which can be inserted into your project...")
        }
    }

    func handleMutationPointDiscoveryFinished(notification: Notification) {
        if reporter == .plainText {
            let discoveredMutationPoints = notification.object as! [MutationPoint]
            numberOfMutationPoints = discoveredMutationPoints.count
            let numberOfFiles = discoveredMutationPoints.map { $0.fileName }.deduplicated().count
            
            print("In total, Muter discovered \(discoveredMutationPoints.count) mutants in \(numberOfFiles) files\n")
            for (fileName, mutantCount) in mutationPointsByFileName(from: discoveredMutationPoints) {
                print("\(fileName) (\(mutantCount) mutants)".bold)
            }
        }
    }
    
    func mutationPointsByFileName(from mutationPoints: [MutationPoint]) -> [String: Int] {
        var result: [String: Int] = [:]
        
        for mutationPoint in mutationPoints {
            if result[mutationPoint.fileName] == nil {
                result[mutationPoint.fileName] = 1
                continue
            }
            
            result[mutationPoint.fileName]! += 1
        }
        return result
    }

    func handleMutationTestingStarted(notification: Notification) {
        if reporter == .plainText {
            printMessage("Mutation testing will now begin\nRunning your test suite to determine a baseline for mutation testing...")
        }
    }

    func handleNewMutationTestOutcomeAvailable(notification: Notification) {
        let outcome = notification.object as! MutationTestOutcome
        
        if reporter == .xcode {
            print(reporter.generateReport(from: [outcome]))
            flushStdOut()
        }
    }

    func handleNewTestLogAvailable(notification: Notification) {
        guard let (mutationPoint, testLog, timePerBuildTestCycle, remainingMutationPointsCount) = notification.object as? (MutationPoint?, String, TimeInterval?, Int?) else {
            return
        }
        
        if reporter == .plainText {
            if mutationPoint == nil {
                print("""
                Determined baseline for mutation testing
                Muter is now going to apply each mutant one at a time and run your test suite for each mutant
                After this step, Muter will generate a report detailing the efficacy of your test suite
                This step may take a while
                

                """)
                progressBar = ProgressBar(count: numberOfMutationPoints,
                                          configuration: [
                                            ProgressString(string: "Inserting mutant"),
                                            ProgressOneIndexed(),
                                            ProgressString(string: "\nPercentage complete: "),
                                            ProgressPercent(),
                                            ColoredProgressBarLine(barLength: 50),
                                            SimpleTimeEstimate(initialEstimate: Double(remainingMutationPointsCount!) * timePerBuildTestCycle!)
                                          ],
                                          printer: ProgressBarMultilineTerminalPrinter(numberOfLines: 2))
                progressBar.next()
            } else {
                progressBar.next()
            }
        }
        
        _ = fileManager.createFile(
            atPath: "\(loggingDirectory)/\(logFileName(from: mutationPoint))",
            contents: testLog.data(using: .utf8),
            attributes: nil
        )
    }
    
    func logFileName(from mutationPoint: MutationPoint?) -> String {
        guard let mutationPoint = mutationPoint else {
            return "baseline run.log"
        }
                
        return "\(mutationPoint.mutationOperatorId.rawValue) @ \(mutationPoint.fileName)-\(mutationPoint.position.line)-\(mutationPoint.position.column).log"
    }

    func handleMutationTestingFinished(notification: Notification) {
        let outcomes = notification.object as! [MutationTestOutcome]
        switch reporter {
        case .json:
            print(reporter.generateReport(from: outcomes))
        case .plainText:
            printMessage(reporter.generateReport(from: outcomes))
        case .xcode: // xcode reports are generated in real-time, generate report footer only
            print(reporter.generateReport(from: outcomes, footerOnly: true))
        }
    }
}
