import SwiftUI
import OpenAPIURLSession

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

            ResponsePropertyView(objects: users)
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
}

#Preview {
    ContentView()
}
