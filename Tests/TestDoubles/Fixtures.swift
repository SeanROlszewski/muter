@testable import muterCore

import Foundation
import SwiftSyntax

extension MuterTestReport.AppliedMutationOperator {
    static func make(
        mutationPoint: MutationPoint = .make(),
        mutationSnapshot: MutationOperatorSnapshot = .make(),
        testSuiteOutcome: TestSuiteOutcome = .passed
    ) -> Self {
        Self(
            mutationPoint: mutationPoint,
            mutationSnapshot: mutationSnapshot,
            testSuiteOutcome: testSuiteOutcome
        )
    }
}

extension MutationOperatorSnapshot {
    static func make(
        before: String = "",
        after: String = "",
        description: String = ""
    ) -> Self {
        Self(
            before: before,
            after: after,
            description: description
        )
    }
}

extension MutationTestOutcome {
    static func make(
        testSuiteOutcome: TestSuiteOutcome = .passed,
        mutationPoint: MutationPoint = .make(),
        mutationSnapshot: MutationOperatorSnapshot = .null,
        originalProjectDirectoryUrl: URL = URL(fileURLWithPath: "")
    ) -> Self {
        Self(
            testSuiteOutcome: testSuiteOutcome,
            mutationPoint: mutationPoint,
            mutationSnapshot: mutationSnapshot,
            originalProjectDirectoryUrl: originalProjectDirectoryUrl
        )
    }
}

extension MuterTestReport.FileReport {
    static func make(
        name: String,
        path: String,
        mutationScore: Int,
        appliedOperators: [MuterTestReport.AppliedMutationOperator]
    ) -> Self {
        Self(
            fileName: name,
            path: path,
            mutationScore: mutationScore,
            appliedOperators: appliedOperators
        )
    }
}

extension MuterTestReport.AppliedMutationOperator {
    static func make(
        mutationOperator: MutationOperator.Id = .logicalOperator,
        position: SwiftSyntax.SourceLocation = .init(integerLiteral: 0),
        mutationSnapshot: MutationOperatorSnapshot = .null,
        testOutcome: TestSuiteOutcome = .passed
    ) -> Self {
        Self(
            mutationPoint: .make(
                mutationOperatorId: mutationOperator,
                filePath: "filePath",
                position: MutationPosition(sourceLocation: position)
            ), mutationSnapshot: mutationSnapshot,
            testSuiteOutcome: testOutcome
        )
    }
}

extension MutationPoint {
    static func make(
        mutationOperatorId: MutationOperator.Id = .logicalOperator,
        filePath: String = "",
        position: MutationPosition = 10
    ) -> Self {
        Self(
            mutationOperatorId: mutationOperatorId,
            filePath: filePath,
            position: position
        )
    }
}

func nextMutationOperator(
    _ index: Int
) -> MutationOperator.Id {
    MutationOperator.Id.allCases[circular: index]
}

func nextMutationTestOutcome(
    _ index: Int
) -> TestSuiteOutcome {
    TestSuiteOutcome.allCases[circular: index]
}

extension MutationPosition: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(
            sourceLocation: .init(integerLiteral: value)
        )
    }
}

extension SwiftSyntax.SourceLocation: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(line: value, column: value, offset: value, file: "")
    }
}

extension Array {
    subscript(circular index: Int) -> Element {
        self[Swift.max(index, 1) % count]
    }
}