
import SwiftUI
import SimpleToast

// MARK: - View

struct ResponseView<T: Encodable>: View {
    @State var showToast: Bool = false
    let objects: [T]
    
    public var body: some View {
        Section {
            NavigationLink {
                ScrollView {
                    VStack(alignment: .leading) {
                        SelectableTextView(text: "\(try! JSONHandler.jsonString(objects: objects))")
                    }
                    .padding()
                }
                .navigationTitle("Response")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            onTapElement(object: objects)
                        } label : {
                            Image(systemName: "doc.on.doc")
                        }
                    }
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
            } label: {
                Text("Response")
            }
        }
    }
    
    func onTapElement(object: Any) {
        UIPasteboard.general.string = {
            do {
                return try JSONHandler.jsonString(object: object)
            } catch {
                return "\(object)"
            }
        }()
        
        showToast = true
    }
}

#Preview {
    NavigationStack {
        List {
            ResponseView(objects: [
                Persons(persons: [
                    Person(name: "John Doe", age: 30, isEmployed: true, address: [
                        Address(city: ["New Yorあああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああk", "トーキョー"], postalCode: [10001, 10002], cityType: .urban),
                        Address(city: ["New York", "トーキョー"], postalCode:[10001, 10002], cityType: .urban),
                    ]),
                    Person(name: "John Doe", age: 30, isEmployed: true, address: [
                        Address(city: ["New York", "トーキョー"], postalCode: [10001, 10002], cityType: .urban),
                        Address(city: ["New York", "トーキョー"], postalCode: [10001, 10002], cityType: .urban),
                    ])
                ])
            ])
        }
    }
}
