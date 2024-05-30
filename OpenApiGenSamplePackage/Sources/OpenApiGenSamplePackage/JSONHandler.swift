
import Foundation

// MARK: Driver

class JSONHandler {
    static func jsonString(object: Any) throws -> String {
        guard let encodableObject = object as? Encodable else {
            print("\(CancellationError())")
            throw CancellationError()
        }

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        let data = try encoder.encode(encodableObject)
        
        guard let jsonString = String(data: data, encoding: .utf8) else {
            print("\(CancellationError())")
            throw CancellationError()
        }

        return jsonString
    }
    
    static func jsonString<U: Encodable>(objects: [U]) throws -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        let data = try encoder.encode(objects)
        guard let jsonString = String(data: data, encoding: .utf8) else {
            print("\(CancellationError())")
            throw CancellationError()
        }

        print("\(jsonString)")
        
        return jsonString
    }
}
