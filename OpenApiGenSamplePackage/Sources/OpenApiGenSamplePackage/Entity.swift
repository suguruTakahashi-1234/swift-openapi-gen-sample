
import Foundation

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
