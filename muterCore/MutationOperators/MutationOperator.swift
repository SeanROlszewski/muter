import SwiftSyntax
import Foundation

typealias SourceCodeTransformation = (SourceFileSyntax) -> (mutatedSource: SyntaxProtocol, description: String)
typealias RewriterInitializer = (MutationPosition) -> PositionSpecificRewriter
typealias VisitorInitializer = (MuterConfiguration, SourceFileInfo) -> PositionDiscoveringVisitor

public struct MutationPoint: Equatable, Codable {
    let mutationOperatorId: MutationOperator.Id
    let filePath: String
    let position: MutationPosition
    
    var fileName: String {
        return URL(fileURLWithPath: self.filePath).lastPathComponent
    }
    
    var mutationOperator: SourceCodeTransformation {
        return mutationOperatorId.mutationOperator(for: position)
    }
}

struct MutationOperator {
    public enum Id: String, Codable, CaseIterable {
        case ror = "RelationalOperatorReplacement"
        case removeSideEffects = "RemoveSideEffects"
        case logicalOperator = "ChangeLogicalConnector"
        
        var rewriterVisitorPair: (rewriter: RewriterInitializer, visitor: VisitorInitializer) {
            switch self {
            case .removeSideEffects:
               return (rewriter: RemoveSideEffectsOperator.Rewriter.init,
                       visitor: RemoveSideEffectsOperator.Visitor.init)
            case .ror:
                return (rewriter: ROROperator.Rewriter.init,
                        visitor: ROROperator.Visitor.init)
            case .logicalOperator:
                return (rewriter: ChangeLogicalConnectorOperator.Rewriter.init,
                        visitor: ChangeLogicalConnectorOperator.Visitor.init)
            }
        }
        
        func mutationOperator(for position: MutationPosition) -> SourceCodeTransformation {
            return { source in
                let visitor = self.rewriterVisitorPair.rewriter(position)
                let mutatedSource = visitor.visit(source)
                return (
                    mutatedSource: mutatedSource,
                    description: visitor.description
                )
            }
        }
    }
}

protocol PositionSpecificRewriter: CustomStringConvertible {
    var positionToMutate: MutationPosition { get }
    
    init(positionToMutate: MutationPosition)
    
    func visit(_ node: SourceFileSyntax) -> Syntax
}

protocol PositionDiscoveringVisitor {
    var positionsOfToken: [MutationPosition] { get }
    init(configuration: MuterConfiguration?, sourceFileInfo: SourceFileInfo)

    func walk<SyntaxType: SyntaxProtocol>(_ node: SyntaxType)
}
