//
//  QueryArgumentFromFunctionCallParser.swift
//  Graphaello
//
//  Created by Mathias Quintero on 12/8/19.
//  Copyright © 2019 Mathias Quintero. All rights reserved.
//

import Foundation
import SwiftSyntax

extension SubParser {
    
    static func functionCall() -> SubParser<FunctionCallExprSyntax, Argument.QueryArgument> {
        return .init { expression in
            if let calledMember = expression.calledExpression.withoutErasure() as? MemberAccessExprSyntax,
                calledMember.name.text == "withDefault" {

                guard let argument = Array(expression.argumentList).single() else {
                    throw ParseError.cannotInstantiateObjectFromExpression(expression,
                                                                           type: Argument.QueryArgument.self)

                }
                return .withDefault(argument.expression)
            } else {
                return .withDefault(expression)
            }
        }
    }
    
}
