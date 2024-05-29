//
//  File.swift
//  
//
//  Created by Suguru Takahashi on 2024/05/29.
//

import SwiftUI

struct PropertyView: View {
    var objects: [Any] = []
    
    init(objects: [Any]) {
        self.objects = objects
    }

    public var body: some View {
        List {
            ForEach(Array(objects.enumerated()), id: \.offset) { index, object in
                DisclosureGroup {
                    propertyView(object: object)
                } label: {
                    HStack {
                        Text("\(type(of: object))")
                        Spacer()
                        Text("\(type(of: object))[\(index)]")
                    }
                }
            }
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
                            propertyView(object: subObject)
                        }
                    } label: {
                        HStack {
                            Text(label)
                            Spacer()
                            Text("\(Mirror(reflecting: child.value).subjectType)")
                        }
                    }
                } else {
                    Button {
                        UIPasteboard.general.string = "\(child.value)"
                        print("\(child.value)")
                    } label: {
                        HStack {
                            Text(label)
                            Spacer()
                            Text("\(child.value)")
                        }
                    }
                }
            }
        })
    }
}

struct Address {
    var city: [String]
    var postalCode: [Int]
}

struct Person {
    var name: String
    var age: Int
    var isEmployed: Bool
    var address: [Address]
}

#Preview {
    NavigationStack {
        PropertyView(objects: [
            Person(name: "John Doe", age: 30, isEmployed: true, address: [
                Address(city: ["New York", "トーキョー"], postalCode: [10001, 10002]),
                Address(city: ["New York", "トーキョー"], postalCode:[10001, 10002]),
            ]),
            Person(name: "John Doe", age: 30, isEmployed: true, address: [
                Address(city: ["New York", "トーキョー"], postalCode: [10001, 10002]),
                Address(city: ["New York", "トーキョー"], postalCode: [10001, 10002]),
            ])
        ])
    }
}
