//
//  API.swift
//  GraphQLCLI
//
//  Created by Mathias Quintero on 12/4/19.
//  Copyright © 2019 Mathias Quintero. All rights reserved.
//

import Foundation
import PathKit

class API {
    let name: String
    let query: Schema.GraphQLType
    let mutation: Schema.GraphQLType?
    let types: [Schema.GraphQLType]
    let scalars: [Schema.GraphQLType]
    let path: Path
    let url: URL?

    init(name: String, schema: Schema, path: Path, url: URL?) {
        self.name = name

        self.query = schema.types.first { $0.name == schema.queryType.name } ?! fatalError("Expected a query type")
        self.mutation = schema.mutationType.map { mutationType in
            schema.types.first { $0.name == mutationType.name } ?! fatalError("Expected the referenced mutation type to exist")
        }

        let alreadyIncluded = Set([schema.queryType.name, schema.mutationType?.name].compactMap { $0 })

        self.types = schema.types
            .filter { $0.includeInReport }
            .filter { !alreadyIncluded.contains($0.name) }
        
        self.scalars = schema.types.filter { $0.isScalar }
        self.path = path
        self.url = url
    }
}

extension API: Hashable {

    static func == (lhs: API, rhs: API) -> Bool {
        return lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(query)
        hasher.combine(mutation)
        hasher.combine(types)
        hasher.combine(scalars)
        hasher.combine(url)
    }

}
