
import Foundation

enum APIType: CaseIterable {
    case all
    case getUsers
    case getUser
}

enum APIError: LocalizedError {
    case notFound
    case undocumented
    
    // alert title
    var errorDescription: String? {
        "\(self)"
    }
}

struct AllResponse: Codable {
    let getUsers: [Components.Schemas.User]
    let getUserById: [Components.Schemas.User]
}


// MARK: - Sample Entity

enum CityType: Codable {
    case urban
    case rural
}

struct Address: Codable {
    var city: [String]
    var postalCode: [Int]
    var cityType: CityType
}

struct Person: Codable {
    var name: String
    var age: Int
    var isEmployed: Bool
    var address: [Address]
}

struct Persons: Codable {
    var persons: [Person]
}

