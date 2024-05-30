
import SwiftUI
import SimpleToast

// MARK: - View

struct PropertyView<T: Encodable>: View {
    @Binding var showToast: Bool
    let objects: [T]

    public var body: some View {
        ForEach(Array(objects.enumerated()), id: \.offset) { index, object in
            Section {
                propertyView(object: object)
            } header: {
                HStack {
                    Text("\(type(of: object))[\(index)]")
                    
                    Spacer()
                    
                    Button {
                        onTapElement(object: object)
                    } label : {
                        Image(systemName: "doc.on.doc")
                    }
                    .buttonStyle(.borderless)
                }
            }
            .textCase(.none)
        }
    }

    func propertyView(object: Any) -> some View {
        AnyView(ForEach(Array(Mirror(reflecting: object).children.enumerated()), id: \.offset) { index, child in
            if let label = child.label {
                let childMirror = Mirror(reflecting: child.value)
                if childMirror.displayStyle == .struct || childMirror.displayStyle == .class {
                    DisclosureGroup {
                        propertyView(object: child.value)
                    } label: {
                        Text(label)
                    }
                } else if let subObjects = child.value as? [Any] {
                    DisclosureGroup {
                        ForEach(Array(subObjects.enumerated()), id: \.offset) { subIndex, subObject in
                            let subObjectMirror = Mirror(reflecting: subObject)
                            if subObjectMirror.displayStyle == .struct || subObjectMirror.displayStyle == .class {
                                DisclosureGroup {
                                    propertyView(object: subObject)
                                } label: {
                                    HStack(alignment: .top) {
                                        Text("\(type(of: subObject))")
                                            .foregroundStyle(.black)
                                        Spacer()
                                        Text("\(type(of: subObject))[\(subIndex)]")
                                    }
                                }
                            } else {
                                Button {
                                    onTapElement(object: subObject)
                                } label: {
                                    HStack(alignment: .top) {
                                        Text("[\(subIndex)]")
                                            .foregroundStyle(.black)
                                        Spacer()
                                        Text("\(subObject)")
                                    }
                                }
                            }
                        }
                    } label: {
                        HStack(alignment: .top) {
                            Text(label)
                                .foregroundStyle(.black)
                            Spacer()
                            Text("\(Mirror(reflecting: child.value).subjectType)")
                        }
                    }
                } else {
                    Button {
                        onTapElement(object: child.value)
                    } label: {
                        HStack(alignment: .top) {
                            Text(label)
                                .foregroundStyle(.black)
                            Spacer()
                            Text("\(child.value)")
                        }
                    }
                }
            } else {
                Button {
                    onTapElement(object: child.value)
                } label: {
                    HStack(alignment: .top) {
                        Text("[\(index)]")
                            .foregroundStyle(.black)
                        Spacer()
                        Text("\(child.value)")
                    }
                }
            }
        })
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

// MARK: - Preview

#Preview {
    NavigationStack {
        List {
            PropertyView(showToast: .constant(false), objects: [
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
