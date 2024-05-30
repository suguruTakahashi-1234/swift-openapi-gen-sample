import SwiftUI
import OpenAPIURLSession
import SimpleToast

enum ApiType: CaseIterable {
    case getUsers
    case getUser
}

public struct ContentView: View {
    @State var showToast: Bool = false
    @State var users: [Components.Schemas.User] = []
    @State var userId: Int = 1
    @State var selectedApi: ApiType = .getUsers
    let client: Client

    public init() {
        self.client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
    }

    public var body: some View {
        NavigationStack {
            List {
                Picker("API", selection: $selectedApi) {
                    Text("getUsers")
                        .tag(ApiType.getUsers)
                    Text("getUser").tag(ApiType.getUser)
                }
                .pickerStyle(.navigationLink)

                if selectedApi == .getUser {
                    TextField("User id", value: $userId, format: .number)
                }

                Button {
                    Task {
                        await executeSelectedAPI()
                    }
                } label: {
                    Text("Execute")
                }
    
                ResponseView(objects: users)
                PropertyView(showToast: $showToast, objects: users)
            }
            .simpleToast(isPresented: $showToast, options: SimpleToastOptions(
                alignment: .bottom,
                hideAfter: 1
            )) {
                Label {
                    Text("Copy")
                } icon: {
                    Image(systemName: "checkmark.circle")
                }
                .padding()
                .background(Color.green.opacity(0.8))
                .foregroundColor(Color.white)
                .cornerRadius(12)
                .padding(.top)
            }
        }
        
    }
    
    func executeSelectedAPI() async {
        switch selectedApi {
        case .getUsers:
            await getUsers()
        case .getUser:
            await getUser(id: userId)
        }
    }

    private func getUsers() async {
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

    private func getUser(id: Int) async {
        let response = try! await client.getUserById(path: .init(id: id))

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
