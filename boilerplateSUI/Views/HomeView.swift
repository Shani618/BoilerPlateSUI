import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            Text("Welcome to Home")
            Button("Logout") {
                appState.isAuthenticated = false
            }
        }
    }
} 