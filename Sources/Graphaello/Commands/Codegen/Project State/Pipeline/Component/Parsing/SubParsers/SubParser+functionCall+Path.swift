//
//  PathFromFunctionCallParser.swift
//  Graphaello
//
//  Created by Mathias Quintero on 12/8/19.
//  Copyright © 2019 Mathias Quintero. All rights reserved.
//

import Foundation
import SwiftSyntax

extension SubParser {
    
    static func functionCall(parent: SubParser<ExprSyntax, Stage.Parsed.Path>,
                             parser: @escaping () -> SubParser<FunctionCallArgumentListSyntax, [Field.Argument]>) -> SubParser<FunctionCallExprSyntax, Stage.Parsed.Path> {
        
        return .init { expression in
            guard let called = expression.calledExpression as? MemberAccessExprSyntax else {
                throw ParseError.cannotInstantiateObjectFromExpression(expression, type: Stage.Parsed.Path.self)
            }

            let arguments = try parser().parse(from: expression.argumentList)

            switch called.base {
            case .some(let base as IdentifierExprSyntax):
                return try Stage.Parsed.Path(apiName: base.identifier.text,
                                             target: .query,
                                             components: []).appending(name: called.name.text, arguments: arguments)
            case .some(let base):
                return try parent.parse(from: base).appending(name: called.name.text, arguments: arguments)

            default:
                throw ParseError.expectedBaseForCalls(expression: expression)

            }
        }
    }
    
}

extension Stage.Parsed.Path {

    fileprivate func appending(name: String, arguments: [Field.Argument]) throws -> Self {
        return .init(apiName: apiName, target: target, components: components + [.call(name, arguments)])
    }

}
