//
//  File.swift
//  
//
//  Created by Suguru Takahashi on 2024/05/29.
//

import SwiftUI
import SimpleToast

// MARK: - View

struct ResponsePropertyView<T: Encodable>: View {
    @State var showToast: Bool = false
    let objects: [T]
    
    init(objects: [T]) {
        self.objects = objects
    }

    public var body: some View {
        List {
            Section {
                DisclosureGroup {
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            Spacer()
                            Button {
                                onTapElement(object: objects)
                            } label : {
                                Image(systemName: "doc.on.doc")
                            }
                            .buttonStyle(.borderless)
                        }

                        Text("\(try! jsonString(objects: objects))")
                    }
                } label: {
                    Text("Response")
                }
            }

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
                return try jsonString(object: object)
            } catch {
                return "\(object)"
            }
        }()
        
        showToast = true
    }

    func jsonString(object: Any) throws -> String {
        guard let encodableObject = object as? Encodable else {
            throw CancellationError()
        }

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        let data = try encoder.encode(encodableObject)
        guard let jsonString = String(data: data, encoding: .utf8) else {
            throw CancellationError()
        }

        return jsonString
    }
    
    func jsonString<U: Encodable>(objects: [U]) throws -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        let data = try encoder.encode(objects)
        guard let jsonString = String(data: data, encoding: .utf8) else {
            throw CancellationError()
        }

        return jsonString
    }
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

// MARK: - Preview

#Preview {
    NavigationStack {
        ResponsePropertyView(objects: [
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
