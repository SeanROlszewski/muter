import Foundation
import SwiftSyntax

func performMutationTesting(using operators: [MutationOperator], delegate: MutationTestingIODelegate) -> MuterTestReport? {

    let initialResult = delegate.runTestSuite(savingResultsIntoFileNamed: "initial_run")
    guard initialResult == .passed else {
        delegate.abortTesting(reason: .initialTestingFailed)
        return nil
    }

    let testOutcomes = apply(operators, delegate: delegate)
    return MuterTestReport(from: testOutcomes)
}

private func apply(_ operators: [MutationOperator], buildErrorsThreshold: Int = 5, delegate: MutationTestingIODelegate, notificationCenter: NotificationCenter = .default) -> [MutationTestOutcome] {
    var outcomes: [MutationTestOutcome] = []
    var buildErrors = 0

    for (index, `operator`) in operators.enumerated() {
        let filePath = `operator`.filePath
        let fileName = URL(fileURLWithPath: filePath).lastPathComponent

        notificationCenter.post(name: .appliedNewMutationOperator, object: (
            fileName: fileName,
            remainingOperatorsCount: operators.count - (index + 1))
        )

        delegate.backupFile(at: filePath)

        let mutatedSource = `operator`.apply()
        try! delegate.writeFile(to: filePath, contents: mutatedSource.description)

        let result = delegate.runTestSuite(savingResultsIntoFileNamed: "\(fileName)_\(`operator`.id.rawValue)_\(`operator`.position).log")
        delegate.restoreFile(at: filePath)

        outcomes.append(
            .init(testSuiteOutcome: result,
                  appliedMutation: `operator`.id,
                  filePath: filePath,
                  position: `operator`.position,
                  operatorDescription: `operator`.description
            )
        )

        buildErrors = result == .buildError ? (buildErrors + 1) : 0

        if buildErrors >= buildErrorsThreshold {
            delegate.abortTesting(reason: .tooManyBuildErrors)
            return []
        }
    }

    return outcomes
}

