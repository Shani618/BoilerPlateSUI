import Foundation
import Combine

class BaseViewModel: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func handleError(_ error: Error) {
        DispatchQueue.main.async {
            self.errorMessage = error.localizedDescription
        }
    }
    
    deinit {
        cancellables.removeAll()
    }
} 