
import SwiftUI

public struct ContentView: View {
    public init () {}
    
    public var body: some View {
        NavigationStack {
            APIRequestView()
        }
    }
}

#Preview {
    ContentView()
}
