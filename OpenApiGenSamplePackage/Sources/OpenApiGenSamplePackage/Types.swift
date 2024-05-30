// Generated by swift-openapi-generator, do not modify.
@_spi(Generated) import OpenAPIRuntime
#if os(Linux)
@preconcurrency import struct Foundation.URL
@preconcurrency import struct Foundation.Data
@preconcurrency import struct Foundation.Date
#else
import struct Foundation.URL
import struct Foundation.Data
import struct Foundation.Date
#endif
/// A type that performs HTTP operations defined by the OpenAPI document.
public protocol APIProtocol: Sendable {
    /// Get a list of users
    ///
    /// - Remark: HTTP `GET /users`.
    /// - Remark: Generated from `#/paths//users/get(getUsers)`.
    func getUsers(_ input: Operations.getUsers.Input) async throws -> Operations.getUsers.Output
    /// Get a user by ID
    ///
    /// - Remark: HTTP `GET /users/{id}`.
    /// - Remark: Generated from `#/paths//users/{id}/get(getUserById)`.
    func getUserById(_ input: Operations.getUserById.Input) async throws -> Operations.getUserById.Output
}

/// Convenience overloads for operation inputs.
extension APIProtocol {
    /// Get a list of users
    ///
    /// - Remark: HTTP `GET /users`.
    /// - Remark: Generated from `#/paths//users/get(getUsers)`.
    public func getUsers(headers: Operations.getUsers.Input.Headers = .init()) async throws -> Operations.getUsers.Output {
        try await getUsers(Operations.getUsers.Input(headers: headers))
    }
    /// Get a user by ID
    ///
    /// - Remark: HTTP `GET /users/{id}`.
    /// - Remark: Generated from `#/paths//users/{id}/get(getUserById)`.
    public func getUserById(
        path: Operations.getUserById.Input.Path,
        headers: Operations.getUserById.Input.Headers = .init()
    ) async throws -> Operations.getUserById.Output {
        try await getUserById(Operations.getUserById.Input(
            path: path,
            headers: headers
        ))
    }
}

/// Server URLs defined in the OpenAPI document.
public enum Servers {
    public static func server1() throws -> Foundation.URL {
        try Foundation.URL(
            validatingOpenAPIServerURL: "https://jsonplaceholder.typicode.com",
            variables: []
        )
    }
}

/// Types generated from the components section of the OpenAPI document.
public enum Components {
    /// Types generated from the `#/components/schemas` section of the OpenAPI document.
    public enum Schemas {
        /// - Remark: Generated from `#/components/schemas/User`.
        public struct User: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/User/id`.
            public var id: Swift.Int
            /// - Remark: Generated from `#/components/schemas/User/name`.
            public var name: Swift.String
            /// - Remark: Generated from `#/components/schemas/User/username`.
            public var username: Swift.String
            /// - Remark: Generated from `#/components/schemas/User/email`.
            public var email: Swift.String
            /// - Remark: Generated from `#/components/schemas/User/address`.
            public struct addressPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/User/address/street`.
                public var street: Swift.String
                /// - Remark: Generated from `#/components/schemas/User/address/suite`.
                public var suite: Swift.String
                /// - Remark: Generated from `#/components/schemas/User/address/city`.
                public var city: Swift.String
                /// - Remark: Generated from `#/components/schemas/User/address/zipcode`.
                public var zipcode: Swift.String
                /// - Remark: Generated from `#/components/schemas/User/address/geo`.
                public struct geoPayload: Codable, Hashable, Sendable {
                    /// - Remark: Generated from `#/components/schemas/User/address/geo/lat`.
                    public var lat: Swift.String
                    /// - Remark: Generated from `#/components/schemas/User/address/geo/lng`.
                    public var lng: Swift.String
                    /// Creates a new `geoPayload`.
                    ///
                    /// - Parameters:
                    ///   - lat:
                    ///   - lng:
                    public init(
                        lat: Swift.String,
                        lng: Swift.String
                    ) {
                        self.lat = lat
                        self.lng = lng
                    }
                    public enum CodingKeys: String, CodingKey {
                        case lat
                        case lng
                    }
                }
                /// - Remark: Generated from `#/components/schemas/User/address/geo`.
                public var geo: Components.Schemas.User.addressPayload.geoPayload
                /// Creates a new `addressPayload`.
                ///
                /// - Parameters:
                ///   - street:
                ///   - suite:
                ///   - city:
                ///   - zipcode:
                ///   - geo:
                public init(
                    street: Swift.String,
                    suite: Swift.String,
                    city: Swift.String,
                    zipcode: Swift.String,
                    geo: Components.Schemas.User.addressPayload.geoPayload
                ) {
                    self.street = street
                    self.suite = suite
                    self.city = city
                    self.zipcode = zipcode
                    self.geo = geo
                }
                public enum CodingKeys: String, CodingKey {
                    case street
                    case suite
                    case city
                    case zipcode
                    case geo
                }
            }
            /// - Remark: Generated from `#/components/schemas/User/address`.
            public var address: Components.Schemas.User.addressPayload
            /// - Remark: Generated from `#/components/schemas/User/phone`.
            public var phone: Swift.String
            /// - Remark: Generated from `#/components/schemas/User/website`.
            public var website: Swift.String
            /// - Remark: Generated from `#/components/schemas/User/company`.
            public struct companyPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/User/company/name`.
                public var name: Swift.String
                /// - Remark: Generated from `#/components/schemas/User/company/catchPhrase`.
                public var catchPhrase: Swift.String
                /// - Remark: Generated from `#/components/schemas/User/company/bs`.
                public var bs: Swift.String
                /// Creates a new `companyPayload`.
                ///
                /// - Parameters:
                ///   - name:
                ///   - catchPhrase:
                ///   - bs:
                public init(
                    name: Swift.String,
                    catchPhrase: Swift.String,
                    bs: Swift.String
                ) {
                    self.name = name
                    self.catchPhrase = catchPhrase
                    self.bs = bs
                }
                public enum CodingKeys: String, CodingKey {
                    case name
                    case catchPhrase
                    case bs
                }
            }
            /// - Remark: Generated from `#/components/schemas/User/company`.
            public var company: Components.Schemas.User.companyPayload
            /// Creates a new `User`.
            ///
            /// - Parameters:
            ///   - id:
            ///   - name:
            ///   - username:
            ///   - email:
            ///   - address:
            ///   - phone:
            ///   - website:
            ///   - company:
            public init(
                id: Swift.Int,
                name: Swift.String,
                username: Swift.String,
                email: Swift.String,
                address: Components.Schemas.User.addressPayload,
                phone: Swift.String,
                website: Swift.String,
                company: Components.Schemas.User.companyPayload
            ) {
                self.id = id
                self.name = name
                self.username = username
                self.email = email
                self.address = address
                self.phone = phone
                self.website = website
                self.company = company
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case name
                case username
                case email
                case address
                case phone
                case website
                case company
            }
        }
        /// - Remark: Generated from `#/components/schemas/Error`.
        public struct _Error: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/Error/code`.
            public var code: Swift.Int?
            /// - Remark: Generated from `#/components/schemas/Error/message`.
            public var message: Swift.String?
            /// Creates a new `_Error`.
            ///
            /// - Parameters:
            ///   - code:
            ///   - message:
            public init(
                code: Swift.Int? = nil,
                message: Swift.String? = nil
            ) {
                self.code = code
                self.message = message
            }
            public enum CodingKeys: String, CodingKey {
                case code
                case message
            }
        }
    }
    /// Types generated from the `#/components/parameters` section of the OpenAPI document.
    public enum Parameters {}
    /// Types generated from the `#/components/requestBodies` section of the OpenAPI document.
    public enum RequestBodies {}
    /// Types generated from the `#/components/responses` section of the OpenAPI document.
    public enum Responses {}
    /// Types generated from the `#/components/headers` section of the OpenAPI document.
    public enum Headers {}
}

/// API operations, with input and output types, generated from `#/paths` in the OpenAPI document.
public enum Operations {
    /// Get a list of users
    ///
    /// - Remark: HTTP `GET /users`.
    /// - Remark: Generated from `#/paths//users/get(getUsers)`.
    public enum getUsers {
        public static let id: Swift.String = "getUsers"
        public struct Input: Sendable, Hashable {
            /// - Remark: Generated from `#/paths/users/GET/header`.
            public struct Headers: Sendable, Hashable {
                public var accept: [OpenAPIRuntime.AcceptHeaderContentType<Operations.getUsers.AcceptableContentType>]
                /// Creates a new `Headers`.
                ///
                /// - Parameters:
                ///   - accept:
                public init(accept: [OpenAPIRuntime.AcceptHeaderContentType<Operations.getUsers.AcceptableContentType>] = .defaultValues()) {
                    self.accept = accept
                }
            }
            public var headers: Operations.getUsers.Input.Headers
            /// Creates a new `Input`.
            ///
            /// - Parameters:
            ///   - headers:
            public init(headers: Operations.getUsers.Input.Headers = .init()) {
                self.headers = headers
            }
        }
        @frozen public enum Output: Sendable, Hashable {
            public struct Ok: Sendable, Hashable {
                /// - Remark: Generated from `#/paths/users/GET/responses/200/content`.
                @frozen public enum Body: Sendable, Hashable {
                    /// - Remark: Generated from `#/paths/users/GET/responses/200/content/application\/json`.
                    case json([Components.Schemas.User])
                    /// The associated value of the enum case if `self` is `.json`.
                    ///
                    /// - Throws: An error if `self` is not `.json`.
                    /// - SeeAlso: `.json`.
                    public var json: [Components.Schemas.User] {
                        get throws {
                            switch self {
                            case let .json(body):
                                return body
                            }
                        }
                    }
                }
                /// Received HTTP response body
                public var body: Operations.getUsers.Output.Ok.Body
                /// Creates a new `Ok`.
                ///
                /// - Parameters:
                ///   - body: Received HTTP response body
                public init(body: Operations.getUsers.Output.Ok.Body) {
                    self.body = body
                }
            }
            /// Success
            ///
            /// - Remark: Generated from `#/paths//users/get(getUsers)/responses/200`.
            ///
            /// HTTP response code: `200 ok`.
            case ok(Operations.getUsers.Output.Ok)
            /// The associated value of the enum case if `self` is `.ok`.
            ///
            /// - Throws: An error if `self` is not `.ok`.
            /// - SeeAlso: `.ok`.
            public var ok: Operations.getUsers.Output.Ok {
                get throws {
                    switch self {
                    case let .ok(response):
                        return response
                    default:
                        try throwUnexpectedResponseStatus(
                            expectedStatus: "ok",
                            response: self
                        )
                    }
                }
            }
            public struct NotFound: Sendable, Hashable {
                /// - Remark: Generated from `#/paths/users/GET/responses/404/content`.
                @frozen public enum Body: Sendable, Hashable {
                    /// - Remark: Generated from `#/paths/users/GET/responses/404/content/application\/json`.
                    case json(Components.Schemas._Error)
                    /// The associated value of the enum case if `self` is `.json`.
                    ///
                    /// - Throws: An error if `self` is not `.json`.
                    /// - SeeAlso: `.json`.
                    public var json: Components.Schemas._Error {
                        get throws {
                            switch self {
                            case let .json(body):
                                return body
                            }
                        }
                    }
                }
                /// Received HTTP response body
                public var body: Operations.getUsers.Output.NotFound.Body
                /// Creates a new `NotFound`.
                ///
                /// - Parameters:
                ///   - body: Received HTTP response body
                public init(body: Operations.getUsers.Output.NotFound.Body) {
                    self.body = body
                }
            }
            /// Not Found
            ///
            /// - Remark: Generated from `#/paths//users/get(getUsers)/responses/404`.
            ///
            /// HTTP response code: `404 notFound`.
            case notFound(Operations.getUsers.Output.NotFound)
            /// The associated value of the enum case if `self` is `.notFound`.
            ///
            /// - Throws: An error if `self` is not `.notFound`.
            /// - SeeAlso: `.notFound`.
            public var notFound: Operations.getUsers.Output.NotFound {
                get throws {
                    switch self {
                    case let .notFound(response):
                        return response
                    default:
                        try throwUnexpectedResponseStatus(
                            expectedStatus: "notFound",
                            response: self
                        )
                    }
                }
            }
            /// Undocumented response.
            ///
            /// A response with a code that is not documented in the OpenAPI document.
            case undocumented(statusCode: Swift.Int, OpenAPIRuntime.UndocumentedPayload)
        }
        @frozen public enum AcceptableContentType: AcceptableProtocol {
            case json
            case other(Swift.String)
            public init?(rawValue: Swift.String) {
                switch rawValue.lowercased() {
                case "application/json":
                    self = .json
                default:
                    self = .other(rawValue)
                }
            }
            public var rawValue: Swift.String {
                switch self {
                case let .other(string):
                    return string
                case .json:
                    return "application/json"
                }
            }
            public static var allCases: [Self] {
                [
                    .json
                ]
            }
        }
    }
    /// Get a user by ID
    ///
    /// - Remark: HTTP `GET /users/{id}`.
    /// - Remark: Generated from `#/paths//users/{id}/get(getUserById)`.
    public enum getUserById {
        public static let id: Swift.String = "getUserById"
        public struct Input: Sendable, Hashable {
            /// - Remark: Generated from `#/paths/users/{id}/GET/path`.
            public struct Path: Sendable, Hashable {
                /// The id of the user to retrieve
                ///
                /// - Remark: Generated from `#/paths/users/{id}/GET/path/id`.
                public var id: Swift.Int
                /// Creates a new `Path`.
                ///
                /// - Parameters:
                ///   - id: The id of the user to retrieve
                public init(id: Swift.Int) {
                    self.id = id
                }
            }
            public var path: Operations.getUserById.Input.Path
            /// - Remark: Generated from `#/paths/users/{id}/GET/header`.
            public struct Headers: Sendable, Hashable {
                public var accept: [OpenAPIRuntime.AcceptHeaderContentType<Operations.getUserById.AcceptableContentType>]
                /// Creates a new `Headers`.
                ///
                /// - Parameters:
                ///   - accept:
                public init(accept: [OpenAPIRuntime.AcceptHeaderContentType<Operations.getUserById.AcceptableContentType>] = .defaultValues()) {
                    self.accept = accept
                }
            }
            public var headers: Operations.getUserById.Input.Headers
            /// Creates a new `Input`.
            ///
            /// - Parameters:
            ///   - path:
            ///   - headers:
            public init(
                path: Operations.getUserById.Input.Path,
                headers: Operations.getUserById.Input.Headers = .init()
            ) {
                self.path = path
                self.headers = headers
            }
        }
        @frozen public enum Output: Sendable, Hashable {
            public struct Ok: Sendable, Hashable {
                /// - Remark: Generated from `#/paths/users/{id}/GET/responses/200/content`.
                @frozen public enum Body: Sendable, Hashable {
                    /// - Remark: Generated from `#/paths/users/{id}/GET/responses/200/content/application\/json`.
                    case json(Components.Schemas.User)
                    /// The associated value of the enum case if `self` is `.json`.
                    ///
                    /// - Throws: An error if `self` is not `.json`.
                    /// - SeeAlso: `.json`.
                    public var json: Components.Schemas.User {
                        get throws {
                            switch self {
                            case let .json(body):
                                return body
                            }
                        }
                    }
                }
                /// Received HTTP response body
                public var body: Operations.getUserById.Output.Ok.Body
                /// Creates a new `Ok`.
                ///
                /// - Parameters:
                ///   - body: Received HTTP response body
                public init(body: Operations.getUserById.Output.Ok.Body) {
                    self.body = body
                }
            }
            /// Success
            ///
            /// - Remark: Generated from `#/paths//users/{id}/get(getUserById)/responses/200`.
            ///
            /// HTTP response code: `200 ok`.
            case ok(Operations.getUserById.Output.Ok)
            /// The associated value of the enum case if `self` is `.ok`.
            ///
            /// - Throws: An error if `self` is not `.ok`.
            /// - SeeAlso: `.ok`.
            public var ok: Operations.getUserById.Output.Ok {
                get throws {
                    switch self {
                    case let .ok(response):
                        return response
                    default:
                        try throwUnexpectedResponseStatus(
                            expectedStatus: "ok",
                            response: self
                        )
                    }
                }
            }
            public struct NotFound: Sendable, Hashable {
                /// - Remark: Generated from `#/paths/users/{id}/GET/responses/404/content`.
                @frozen public enum Body: Sendable, Hashable {
                    /// - Remark: Generated from `#/paths/users/{id}/GET/responses/404/content/application\/json`.
                    case json(Components.Schemas._Error)
                    /// The associated value of the enum case if `self` is `.json`.
                    ///
                    /// - Throws: An error if `self` is not `.json`.
                    /// - SeeAlso: `.json`.
                    public var json: Components.Schemas._Error {
                        get throws {
                            switch self {
                            case let .json(body):
                                return body
                            }
                        }
                    }
                }
                /// Received HTTP response body
                public var body: Operations.getUserById.Output.NotFound.Body
                /// Creates a new `NotFound`.
                ///
                /// - Parameters:
                ///   - body: Received HTTP response body
                public init(body: Operations.getUserById.Output.NotFound.Body) {
                    self.body = body
                }
            }
            /// Not Found
            ///
            /// - Remark: Generated from `#/paths//users/{id}/get(getUserById)/responses/404`.
            ///
            /// HTTP response code: `404 notFound`.
            case notFound(Operations.getUserById.Output.NotFound)
            /// The associated value of the enum case if `self` is `.notFound`.
            ///
            /// - Throws: An error if `self` is not `.notFound`.
            /// - SeeAlso: `.notFound`.
            public var notFound: Operations.getUserById.Output.NotFound {
                get throws {
                    switch self {
                    case let .notFound(response):
                        return response
                    default:
                        try throwUnexpectedResponseStatus(
                            expectedStatus: "notFound",
                            response: self
                        )
                    }
                }
            }
            /// Undocumented response.
            ///
            /// A response with a code that is not documented in the OpenAPI document.
            case undocumented(statusCode: Swift.Int, OpenAPIRuntime.UndocumentedPayload)
        }
        @frozen public enum AcceptableContentType: AcceptableProtocol {
            case json
            case other(Swift.String)
            public init?(rawValue: Swift.String) {
                switch rawValue.lowercased() {
                case "application/json":
                    self = .json
                default:
                    self = .other(rawValue)
                }
            }
            public var rawValue: Swift.String {
                switch self {
                case let .other(string):
                    return string
                case .json:
                    return "application/json"
                }
            }
            public static var allCases: [Self] {
                [
                    .json
                ]
            }
        }
    }
}
