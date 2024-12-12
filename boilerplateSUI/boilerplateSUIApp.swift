import SwiftUI

@main
struct boilerplateSUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AppState())
        }
    }
} 