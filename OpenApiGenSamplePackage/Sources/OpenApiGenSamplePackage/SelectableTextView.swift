//
//  File.swift
//  
//
//  Created by Suguru Takahashi on 2024/05/29.
//

import SwiftUI
import UIKit

struct SelectableText: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = true
        textView.text = text
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.backgroundColor = UIColor.clear
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}

#Preview {
    SelectableText(text: .constant("hoge"))
}
