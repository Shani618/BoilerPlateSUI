import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            Text("Login")
            Button("Login") {
                appState.isAuthenticated = true
            }
        }
    }
}

class LoginViewModel: BaseViewModel {
    @Published var email = ""
    @Published var password = ""
    
    func login() {
        // Implement login logic
    }
} 