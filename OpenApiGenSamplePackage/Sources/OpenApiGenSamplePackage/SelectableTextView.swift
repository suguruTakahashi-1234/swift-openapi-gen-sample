
import SwiftUI
import UIKit

struct SelectableTextView: UIViewRepresentable {
    let text: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = true
        textView.text = text
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.backgroundColor = UIColor.clear
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
    // これがないとスクロールが途中で止まってしまう
    func sizeThatFits(_ proposal: ProposedViewSize, uiView: UITextView, context: Context) -> CGSize? {
        let targetSize = CGSize(width: proposal.width ?? uiView.frame.width, height: CGFloat.greatestFiniteMagnitude)
        let size = uiView.sizeThatFits(targetSize)
        return CGSize(width: proposal.width ?? size.width, height: size.height)
    }
}

#Preview {
    ScrollView {
        VStack {
            SelectableTextView(text: """
[
   {
     "address" : {
































       "city" : "123456789012345678901234567890123456789012345678901234567890",
       "city" : "123456789012345678901234567890123456789012345678901234567890",
       "city" : "123456789012345678901234567890123456789012345678901234567890",
       "city" : "123456789012345678901234567890123456789012345678901234567890",
       "city" : "123456789012345678901234567890123456789012345678901234567890",
       "city" : "123456789012345678901234567890123456789012345678901234567890",
       "city" : "123456789012345678901234567890123456789012345678901234567890",
       "city" : "123456789012345678901234567890123456789012345678901234567890",
       "city" : "123456789012345678901234567890123456789012345678901234567890",

"""
            )
        }
        .padding()
    }
}
