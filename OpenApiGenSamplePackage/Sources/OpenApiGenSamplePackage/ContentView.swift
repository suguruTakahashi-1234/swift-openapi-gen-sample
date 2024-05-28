//
//  File.swift
//  
//
//  Created by Suguru Takahashi on 2024/05/28.
//

import SwiftUI
import OpenAPIRuntime
import OpenAPIURLSession

extension Components.Schemas.User: Identifiable {}

public struct ContentView: View {
    @State var users: [Components.Schemas.User] = []
    let client: Client

    public init() {
        self.client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
    }

    public var body: some View {
        HStack {
            Button {
                Task {
                    await getUsers()
                }
            } label: {
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("getUsers")
                }
                .padding()
            }
            
            Button {
                Task {
                    await getUser()
                }
            } label: {
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("getUser")
                }
                .padding()
            }

        }

        List(users) { user in
            Section {
                ForEach(getPropertiesAndValues(object: user), id: \.property) { property, value in
                    Text("\(property): \(value)")
                }
            }
        }
    }

    func getUsers() async {
        let response = try! await client.getUsers()
        
        switch response {
        case .ok(let okResponse):
            switch okResponse.body {
            case .json(let users):
                self.users = users
            }
        case .undocumented(statusCode: let statusCode, _):
            print("\(statusCode)")
        }
    }

    func getUser() async {
        let response = try! await client.getUserById(path: .init(id: 1))

        switch response {
        case .ok(let okResponse):
            switch okResponse.body {
            case .json(let user):
                self.users = [user]
            }
        case .undocumented(statusCode: let statusCode, _):
            print("\(statusCode)")
        }
    }
    
    /// 変数名とその値のタプルの配列を返す関数
    private func getPropertiesAndValues(object: Any) -> [(property: String, value: String)] {
        let mirror = Mirror(reflecting: object)
        return mirror.children.compactMap { child in
            guard let label = child.label else {
                return nil
            }
            return (label, String(describing: child.value))
        }
    }
}

#Preview {
    ContentView()
}

