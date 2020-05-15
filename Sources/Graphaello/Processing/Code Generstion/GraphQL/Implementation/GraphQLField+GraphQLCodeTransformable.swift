import Foundation
import Stencil

extension GraphQLField: ExtraValuesGraphQLCodeTransformable {
    func arguments(from context: Stencil.Context, arguments: [Any?]) throws -> [String : Any] {
        guard context["isInsideFragment"] == nil else { return ["name": field.name] }
        switch field {
        case .direct:
            return ["name": field.name]
        case .call(_, let arguments):
            let sortedKeys = arguments.sorted { $0.name <= $1.name }
            return [
                "name": field.name,
                "arguments": sortedKeys.map {
                    FieldArgument(name: $0.name, queryArgumentName: $0.queryArgumentName)
                } as [FieldArgument]
            ]
        }
    }
}
