//
//  Argument.swift
//  GraphQLCLI
//
//  Created by Mathias Quintero on 12/4/19.
//  Copyright © 2019 Mathias Quintero. All rights reserved.
//

import Foundation
import Ogma

extension Schema.GraphQLType.Field {

    struct Argument: Codable, Equatable, Hashable {
        let name: String

        @OptionalParsed<GraphQLValue.Lexer, GraphQLValue>
        var defaultValue: GraphQLValue?

        let `type`: TypeReference
    }

}
