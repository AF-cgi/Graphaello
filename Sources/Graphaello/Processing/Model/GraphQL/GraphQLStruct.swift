//
//  GraphQLStruct.swift
//  GraphQLCLI
//
//  Created by Mathias Quintero on 06.12.19.
//  Copyright © 2019 Mathias Quintero. All rights reserved.
//

import Foundation

struct GraphQLStruct {
    let definition: Struct<Stage.Resolved>
    let fragments: [GraphQLFragment]
    let query: GraphQLQuery?
    let connectionQueries: [GraphQLConnectionQuery]
}

extension GraphQLStruct {
    
    static func + (lhs: GraphQLStruct, rhs: GraphQLFragment) -> GraphQLStruct {
        let includesFragment = lhs.fragments.contains { $0 ~= rhs }
        if includesFragment {
            let fragments = lhs.fragments.map { $0 ~= rhs ? $0 + rhs : $0 } as [GraphQLFragment]
            return GraphQLStruct(definition: lhs.definition,
                                 fragments: fragments,
                                 query: lhs.query,
                                 connectionQueries: lhs.connectionQueries)
        } else {
            return GraphQLStruct(definition: lhs.definition,
                                 fragments: lhs.fragments + [rhs],
                                 query: lhs.query,
                                 connectionQueries: lhs.connectionQueries)
        }
    }
    
    static func + (lhs: GraphQLStruct, rhs: GraphQLQuery) throws -> GraphQLStruct {
        return GraphQLStruct(definition: lhs.definition,
                             fragments: lhs.fragments,
                             query: try lhs.query + rhs,
                             connectionQueries: lhs.connectionQueries)
    }

    static func + (lhs: GraphQLStruct, rhs: GraphQLConnectionQuery) -> GraphQLStruct {
        return GraphQLStruct(definition: lhs.definition,
                             fragments: lhs.fragments,
                             query: lhs.query,
                             connectionQueries: lhs.connectionQueries + [rhs])
    }
    
}
