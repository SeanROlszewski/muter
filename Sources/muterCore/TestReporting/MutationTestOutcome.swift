import SwiftSyntax

public struct MutationTestOutcome: Equatable {
    let testSuiteOutcome: TestSuiteOutcome
    let appliedMutation: MutationOperator.Id
    let filePath: String
    let position: AbsolutePosition
    let operatorDescription: String

    public init(testSuiteOutcome: TestSuiteOutcome,
                appliedMutation: MutationOperator.Id,
                filePath: String,
                position: AbsolutePosition,
                operatorDescription: String) {
        self.testSuiteOutcome = testSuiteOutcome
        self.appliedMutation = appliedMutation
        self.filePath = filePath
        self.position = position
        self.operatorDescription = operatorDescription
    }
}
