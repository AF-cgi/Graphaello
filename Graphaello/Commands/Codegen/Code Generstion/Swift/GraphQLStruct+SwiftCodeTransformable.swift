//
//  GraphQLStruct+SwiftCodeTransformable.swift
//  Graphaello
//
//  Created by Mathias Quintero on 06.12.19.
//  Copyright © 2019 Mathias Quintero. All rights reserved.
//

import Foundation
import Stencil

extension GraphQLStruct: ExtraValuesSwiftCodeTransformable {
    
    func arguments(from context: Context, arguments: [Any?]) throws -> [String : Any] {
        let functionName = definition.name.camelized
        return [
            "functionName" : functionName,
            "initializerArguments" : initializerArguments,
            "initializerValueAssignments" : initializerValueAssignments
        ]
    }
    
}
