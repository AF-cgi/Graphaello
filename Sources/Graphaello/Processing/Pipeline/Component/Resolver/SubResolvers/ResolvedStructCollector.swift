//
//  StructFragmentCollector.swift
//  Graphaello
//
//  Created by Mathias Quintero on 09.12.19.
//  Copyright © 2019 Mathias Quintero. All rights reserved.
//

import Foundation

protocol ResolvedStructCollector {
    func collect(from value: Struct<Stage.Resolved>) throws -> StructResolution.Result<Struct<Stage.Resolved>>
}
