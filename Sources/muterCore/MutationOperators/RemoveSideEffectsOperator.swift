import SwiftSyntax
import Foundation

enum RemoveSideEffectsOperator {
    final class Visitor: SyntaxAnyVisitor, PositionDiscoveringVisitor {
        var file: String
        var source: String
        
        var positionsOfToken = [MutationPosition]()
        private var concurencyPropertiesInFile = [String]()
        private let concurrencyTypes = [
            "DispatchSemaphore",
            "NSRecursiveLock",
            "NSCondition",
            "NSConditionLock"
        ]
        
        private let untestedFunctionNames: [String]
        
        init(configuration: MuterConfiguration? = nil, file: String, source: String) {
            untestedFunctionNames = ["print", "fatalError", "exit", "abort"] + (configuration?.excludeCallList ?? [])
            self.file = file
            self.source = source
        }
        
        override func visit(_ node: PatternBindingListSyntax) -> SyntaxVisitorContinueKind {
            for statement in node where statementsContainsConcurrencyTypes(statement) {
                let property = propertyName(from: statement)
                concurencyPropertiesInFile.append(property)
            }
            
            return super.visit(node)
        }
        
        override func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
            guard let body = node.body else {
                return super.visit(node)
            }

            for statement in body.statements where statementContainsMutableToken(statement) {
                let sourceLocation = statement.endLocation(converter: SourceLocationConverter(file: file, source: source), afterTrailingTrivia: true)

                    positionsOfToken.append(
                        MutationPosition(
                            utf8Offset: sourceLocation.offset,
                            line: sourceLocation.line,
                            column: sourceLocation.column
                        )
                    )
            }
            
            return super.visit(node)
        }
        
        private func statementContainsMutableToken(_ statement: CodeBlockItemListSyntax.Element) -> Bool {
            let doesntContainVariableAssignment = statement.children.count(variableAssignmentStatements) == 0
            let containsDiscardedResult = statement.description.contains("_ = ")
            
            let containsFunctionCall = statement.children
                .include(functionCallStatements)
                .exclude(untestedFunctionCallStatements)
                .count >= 1
            
            let doesntContainPossibleDeadlock = !statement.children
                .exclude(concurrencyStatements).isEmpty
            
            return doesntContainVariableAssignment &&
                doesntContainPossibleDeadlock && (containsDiscardedResult || containsFunctionCall)
        }
        
        private func variableAssignmentStatements(_ node: Syntax) -> Bool {
            return  node.is(VariableDeclSyntax.self)
        }
        
        private func functionCallStatements(_ node: Syntax) -> Bool {
            return node.is(FunctionCallExprSyntax.self)
        }
        
        private func concurrencyStatements(_ node: Syntax) -> Bool {
            guard let functionCallSyntax = node.as(FunctionCallExprSyntax.self),
                  let calledExpression = functionCallSyntax.calledExpression.as(MemberAccessExprSyntax.self),
                  let variableName = calledExpression.base?.description.trimmed else {
                return false
            }
            
            return concurencyPropertiesInFile.contains(variableName)
        }
        
        private func untestedFunctionCallStatements(_ node: Syntax) -> Bool {
            return untestedFunctionNames.contains { name in node.description.contains(name) }
        }
        
        private func statementsContainsConcurrencyTypes(_ statement: PatternBindingSyntax) -> Bool {
            guard let functionCallSyntax = statement.initializer?.value.as(FunctionCallExprSyntax.self) else {
                return false
            }
            
            let expressionSyntax = functionCallSyntax.calledExpression
            
            return concurrencyTypes.contains(expressionSyntax.description.trimmed)
        }
        
        private func propertyName(from patternSyntax: PatternBindingSyntax) -> String {
            patternSyntax.pattern.description.trimmed
        }
    }
}

extension RemoveSideEffectsOperator {
    class Rewriter: SyntaxRewriter, PositionSpecificRewriter {
        let positionToMutate: MutationPosition
        let description: String = "removed line"
        
        required init(positionToMutate: MutationPosition) {
            self.positionToMutate = positionToMutate
        }
        
        override func visit(_ node: FunctionDeclSyntax) -> DeclSyntax {
            guard let statements = node.body?.statements,
                  let statementToExclude = statements.first(where: currentLineIsPositionToMutate) else {
                return DeclSyntax(node)
            }
            
            let mutatedFunctionStatements = statements.exclude { $0.description == statementToExclude.description }
            
            let newCodeBlockItemList = SyntaxFactory.makeCodeBlockItemList(mutatedFunctionStatements)
            let newFunctionBody = node.body!.withStatements(newCodeBlockItemList)
            
            return mutated(node, with: newFunctionBody)
        }
        
        private func currentLineIsPositionToMutate(_ currentStatement: CodeBlockItemSyntax) -> Bool {
            return currentStatement.endPosition == positionToMutate
        }
        
        private func mutated(_ node: FunctionDeclSyntax, with body: CodeBlockSyntax) -> DeclSyntax {
            let functionDecl = SyntaxFactory.makeFunctionDecl(
                attributes: node.attributes,
                modifiers: node.modifiers,
                funcKeyword: node.funcKeyword,
                identifier: node.identifier,
                genericParameterClause: node.genericParameterClause,
                signature: node.signature,
                genericWhereClause: node.genericWhereClause,
                body: body
            )
            
            return DeclSyntax(functionDecl)
        }
    }
}
