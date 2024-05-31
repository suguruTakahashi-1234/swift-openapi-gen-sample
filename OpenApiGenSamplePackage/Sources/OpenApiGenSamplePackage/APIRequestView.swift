
import SwiftUI
import OpenAPIURLSession
import SimpleToast
import Shimmer

public struct APIRequestView: View {
    @State var selectedApi: APIType = .getUsers
    
    @State var getUsersResponse: [Components.Schemas.User] = []
    @State var getUserByIdResponse: [Components.Schemas.User] = []
    @State var allResponse: [AllResponse] = []
    
    @State var userId: Int = 1

    @State var showToast: Bool = false
    @State var isLoading: Bool = false
    @State var showAlert: Bool = false
    @State var apiError: APIError?
    
    let client: Client
    
    public init() {
        self.client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
    }
    
    public var body: some View {
        List {
            Section("Request") {
                HStack {
                    Picker(selection: $selectedApi) {
                        ForEach(APIType.allCases, id: \.self) { apiType in
                            Text("\(apiType)")
                        }
                    } label: {
                        Text("API")
                    }
                    .pickerStyle(.menu)
                    
                    Spacer()
                }
                
                Group {
                    switch selectedApi {
                    case .getUsers:
                        EmptyView()
                    case .getUser:
                        VStack(alignment:.leading) {
                            Text("User id")
                                .font(.subheadline)
                            TextField("1", value: $userId, format: .number)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
                        }
                    case .all:
                        EmptyView()
                    }
                }
            }
            .textCase(.none)
            .listRowSeparator(.hidden)
            
            Section("Response") {
                Group {
                    switch selectedApi {
                    case .getUsers:
                        ResponseView(objects: getUsersResponse)
                    case .getUser:
                        ResponseView(objects: getUserByIdResponse)
                    case .all:
                        ResponseView(objects: allResponse)
                    }
                }
                .redacted(reason: isLoading ? .placeholder : [])
                .shimmering(active: isLoading)
            }
            .textCase(.none)

            
            Group {
                switch selectedApi {
                case .all:
                    PropertyView(showToast: $showToast, objects: allResponse)
                case .getUsers:
                    PropertyView(showToast: $showToast, objects: getUsersResponse)
                case .getUser:
                    PropertyView(showToast: $showToast, objects: getUserByIdResponse)
                }
            }
            .redacted(reason: isLoading ? .placeholder : [])
            .shimmering(active: isLoading)
        }
        .scrollDismissesKeyboard(.immediately)
        .simpleToast(isPresented: $showToast, options: SimpleToastOptions(alignment: .bottom, hideAfter: 1)) {
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
            .padding(.bottom)
        }
        .toolbar {
            ToolbarItem(placement: .status) {
                Button {
                    Task {
                        await onTapPlay()
                    }
                } label: {
                    Label {
                        Text("Request")
                    } icon: {
                        Image(systemName: "play.fill")
                    }
                    .labelStyle(.titleAndIcon)
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .navigationTitle("API Request")
        
        .alert(isPresented: $showAlert, error: apiError) {
            Button("OK") {}
        }
    }
    
    func onTapPlay() async {
        
        switch selectedApi {
        case .all:
            await getUsers()
            await getUserById(id: userId)
            
            allResponse = [.init(getUsers: getUsersResponse, getUserById: getUserByIdResponse)]
        case .getUsers:
            await getUsers()
        case .getUser:
            await getUserById(id: userId)
        }
    }
    
    private func getUsers() async {
        getUsersResponse = []
        isLoading = true
        defer {
            isLoading = false
        }
        
        do {
            let response = try await client.getUsers()

            switch response {
            case .ok(let okResponse):
                switch okResponse.body {
                case .json(let users):
                    getUsersResponse = users
                }
            case .notFound(let notFoundResponse):
                switch notFoundResponse.body {
                case .json(let error):
                    print("\(error)")
                    apiError = .notFound
                    showAlert = true
                }
            case .undocumented(statusCode: let statusCode, _):
                print("\(statusCode)")
                apiError = .undocumented
                showAlert = true
            }
        } catch {
            print("\(error)")
            apiError = .unexpected
            showAlert = true
        }
    }
    
    private func getUserById(id: Int) async {
        getUserByIdResponse = []
        isLoading = true
        defer {
            isLoading = false
        }

        do {
            let response = try await client.getUserById(path: .init(id: id))

            switch response {
            case .ok(let okResponse):
                switch okResponse.body {
                case .json(let user):
                    getUserByIdResponse = [user]
                }
            case .notFound(let notFoundResponse):
                switch notFoundResponse.body {
                case .json(let error):
                    print("\(error)")
                    apiError = .notFound
                    showAlert = true
                }
            case .undocumented(statusCode: let statusCode, _):
                print("\(statusCode)")
                apiError = .undocumented
                showAlert = true
            }
        } catch {
            print("\(error)")
            apiError = .unexpected
            showAlert = true
        }
    }
}

#Preview {
    NavigationStack {
        APIRequestView()
    }
}
