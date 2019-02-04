import Foundation
import SwiftSyntax

struct MutationTestOutcome: Equatable {
    let testSuiteResult: TestSuiteResult
    let appliedMutation: String
    let filePath: String
    let position: AbsolutePosition
}

func performMutationTesting(using operators: [MutationOperator], buildErrorsThreshold: Int = 5, delegate: MutationTestingIODelegate) -> [MutationTestOutcome] {
    print("Running your test suite to determine a baseline for mutation testing")
    let initialResult = delegate.runTestSuite(savingResultsIntoFileNamed: "initial_run")
    guard initialResult == .passed else {
        delegate.abortTesting()
        return []
    }

    var outcomes: [MutationTestOutcome] = []
    var buildErrors = 0
    let enumerated = operators.enumerated()

    for (index, `operator`) in enumerated {
        let filePath = `operator`.filePath
        let fileName = URL(fileURLWithPath: filePath).lastPathComponent
        print("Testing mutation operator in \(fileName)")
        print("There are \(operators.count - (index + 1)) left to apply")

        delegate.backupFile(at: filePath)

        let mutatedSource = `operator`.apply()
        try! delegate.writeFile(to: filePath, contents: mutatedSource.description)

        let result = delegate.runTestSuite(savingResultsIntoFileNamed: "\(fileName) \(`operator`.id.rawValue) \(`operator`.position)")
        delegate.restoreFile(at: filePath)

        outcomes.append(
            MutationTestOutcome(testSuiteResult: result,
                                appliedMutation: `operator`.id.rawValue,
                                filePath: filePath,
                                position: `operator`.position)
        )

        buildErrors = result == .buildError ? (buildErrors + 1) : 0

        if buildErrors >= buildErrorsThreshold {
            delegate.tooManyBuildErrors()
            return []
        }
    }

    return outcomes
}

// MARK - Mutation Score Calculation

func mutationScore(from testResults: [TestSuiteResult]) -> Int {
    guard testResults.count > 0 else {
        return -1
    }

    let numberOfFailures = Double(testResults.count { $0 == .failed || $0 == .runtimeError })
    let totalResults = Double(testResults.count { $0 != .buildError })
    return Int((numberOfFailures / totalResults) * 100.0)
}

func mutationScoreOfFiles(from outcomes: [MutationTestOutcome]) -> [String: Int] {
    var mutationScores: [String: Int] = [:]

    let filePaths = outcomes.map { $0.filePath }.deduplicated()
    for filePath in filePaths {
        let testSuiteResults = outcomes.include { $0.filePath == filePath }.map { $0.testSuiteResult }
        mutationScores[filePath] = mutationScore(from: testSuiteResults)
    }

    return mutationScores
}
