@testable import muterCore
import Quick
import Nimble
import SwiftSyntax

class RemoveSideEffectsOperatorSpec: QuickSpec {
    override func spec() {

        func applyMutation(toFileAt path: String,
                           atPosition positionToMutate: AbsolutePosition,
                           expectedOutcome: String) -> (mutatedSource: Syntax, expectedSource: Syntax, rewriter: PositionSpecificRewriter) {

            let rewriter = RemoveSideEffectsOperator.Rewriter(positionToMutate: positionToMutate)

            return (
                mutatedSource: rewriter.visit(sourceCode(fromFileAt: path)!),
                expectedSource: sourceCode(fromFileAt: expectedOutcome)!,
                rewriter
            )
        }

        describe("RemoveSideEffectsOperator.Visitor") {
            it("records the positions of code that causes a side effect") {
                let sourceWithSideEffects = sourceCode(fromFileAt: "\(self.fixturesDirectory)/MutationExamples/SideEffect/unusedReturnResult.swift")!

                let visitor = RemoveSideEffectsOperator.Visitor()
                visitor.visit(sourceWithSideEffects)

                guard visitor.positionsOfToken.count == 4 else {
                    fail("Expected 4 tokens to be discovered, got \(visitor.positionsOfToken.count) instead")
                    return
                }

                expect(visitor.positionsOfToken[0].line).to(equal(3))
                expect(visitor.positionsOfToken[1].line).to(equal(10))
                expect(visitor.positionsOfToken[2].line).to(equal(21))
                expect(visitor.positionsOfToken[3].line).to(equal(38))
            }

            it("records no positions when a file doesn't contain code that causes a side effect") {
                let sourceWithoutSideEffects = sourceCode(fromFileAt: "\(self.fixturesDirectory)/sample.swift")!

                let visitor = RemoveSideEffectsOperator.Visitor()
                visitor.visit(sourceWithoutSideEffects)

                expect(visitor.positionsOfToken).to(haveCount(0))
            }
        }

        describe("RemoveSideEffectsOperator.Rewriter") {
            it("deletes a statement with an explicitly discarded result") {
                let path = "\(self.fixturesDirectory)/MutationExamples/SideEffect/unusedReturnResult.swift"

                let firstExpectedSource = "\(self.mutationExamplesDirectory)/SideEffect/removedUnusedReturnResult_line3.swift"
                let secondExpectedSource = "\(self.mutationExamplesDirectory)/SideEffect/removedUnusedReturnResult_line10.swift"
                let line3 = AbsolutePosition(line: 3, column: -1, utf8Offset: -1)
                let line10 = AbsolutePosition(line: 10, column: -1, utf8Offset: -1)

                let firstResults = applyMutation(toFileAt: path,
                                                 atPosition: line3,
                                                 expectedOutcome: firstExpectedSource)

                let secondResults = applyMutation(toFileAt: path,
                                                  atPosition: line10,
                                                  expectedOutcome: secondExpectedSource)

                expect(firstResults.mutatedSource.description).to(equal(firstResults.expectedSource.description))
                expect(secondResults.mutatedSource.description).to(equal(secondResults.expectedSource.description))
                expect(firstResults.rewriter.description).to(equal("removed line"))
                expect(secondResults.rewriter.description).to(equal("removed line"))
            }

            it("deletes a void function call that spans 1 line") {
                let path = "\(self.fixturesDirectory)/MutationExamples/SideEffect/unusedReturnResult.swift"
                let expectedSourcePath = "\(self.fixturesDirectory)/MutationExamples/SideEffect/removedVoidFunctionCall_line21.swift"
                let line21 = AbsolutePosition(line: 21, column: -1, utf8Offset: -1)

                let results = applyMutation(toFileAt: path, atPosition: line21, expectedOutcome: expectedSourcePath)

                expect(results.mutatedSource.description).to(equal(results.expectedSource.description))
                expect(results.rewriter.description).to(equal("removed line"))
            }

            it("deletes a void function call that spans multiple lines") {
                let path = "\(self.fixturesDirectory)/MutationExamples/SideEffect/unusedReturnResult.swift"
                let expectedSourcePath = "\(self.fixturesDirectory)/MutationExamples/SideEffect/removedVoidFunctionCall_line36.swift"
                let line38 = AbsolutePosition(line: 38, column: -1, utf8Offset: -1)

                let results = applyMutation(toFileAt: path, atPosition: line38, expectedOutcome: expectedSourcePath)

                expect(results.mutatedSource.description) == results.expectedSource.description
                expect(results.rewriter.description.trimmed) == "removed line"
            }
        }

        describe("MutationOperator.Id.sideEffects.transformation") {
            it("behaves like a SideEffectsOperator.Rewriter") {
                let sourceWithSideEffects = sourceCode(fromFileAt: "\(self.fixturesDirectory)/MutationExamples/SideEffect/unusedReturnResult.swift")!
                let expectedSource = sourceCode(fromFileAt:  "\(self.fixturesDirectory)/MutationExamples/SideEffect/removedVoidFunctionCall_line21.swift")!
                let line21 = AbsolutePosition(line: 21, column: -1, utf8Offset: -1)

                let transformation = MutationOperator.Id.removeSideEffects.transformation(for: line21)

                expect(transformation(sourceWithSideEffects).description).to(equal(expectedSource.description))
            }
        }
    }
}
