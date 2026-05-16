import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var results: [Movie] = []
    @Published var isLoading = false
    @Published var searchText = ""
    @Published var errorMessage = ""
    
    func search() {
        isLoading = true
        
        Task {
            do {
                let search = try await TMDBService.shared.searchMovies(query: searchText)
                
                await MainActor.run {
                    results = search
                    isLoading = false
                }
            } catch {
                await MainActor.run {
                    isLoading = false
                }
            }
        }
    }
}
