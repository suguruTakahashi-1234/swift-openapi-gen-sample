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
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    Button {
                        Task {
                            await getUser()
                            await getUsers()
                        }
                    } label: {
                        VStack {
                            Image(systemName: "globe")
                                .imageScale(.large)
                                .foregroundStyle(.tint)
                            Text("All")
                        }
                        .padding()
                    }
                    
                    
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
            }

            List {
                ForEach(users) { user in
                    Section {
                        ForEach(getPropertiesAndValues(of: user), id: \.property) { property, value in
                            Button {
                                UIPasteboard.general.string = value
                            } label: {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(property)
                                        .font(.headline)
                                    Text(value)
                                        .font(.subheadline)
                                }
                            }
                        }
                    } header: {
                        HStack {
                            Text("User \(user.id)")
                                .font(.headline)
                            
                            Spacer()
                            
                            Button {
                                UIPasteboard.general.string = "\(user)"
                            } label : {
                                Image(systemName: "doc.on.doc")
                            }
                            .buttonStyle(.borderless)
                        }
                    }
                }
            }
            .listStyle(.plain)
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
    private func getPropertiesAndValues(of object: Any) -> [(property: String, value: String)] {
        let mirror = Mirror(reflecting: object)
        return mirror.children.compactMap { child in
            guard let label = child.label else {
                return nil
            }
            return (label, String(describing: child.value))
        }
    }
    
    /// オブジェクト全体を文字列としてコピーするための関数
    private func getCopyString(from object: Any) -> String {
        let properties = getPropertiesAndValues(of: object)
        return properties.map { "\($0.property): \($0.value)" }.joined(separator: "\n")
    }
}

#Preview {
    ContentView()
}
