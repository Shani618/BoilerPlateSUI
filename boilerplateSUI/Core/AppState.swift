import Foundation

class AppState: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    
    // Add other global state properties here
}

struct User: Codable {
    let id: String
    let name: String
    let email: String
} 