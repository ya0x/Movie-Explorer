import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var results: [Movie] = []
    @Published var tvResults: [TVShow] = []
    @Published var searchType: SearchType = .movies
    @Published var isLoading = false
    @Published var searchText = ""
    @Published var errorMessage = ""
    
    enum SearchType {
        case movies
        case tvShows
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .filter { !$0.isEmpty }
            .sink { [weak self] query in
                self?.search()
            }
            .store(in: &cancellables)
    }
    
    func search() {
        isLoading = true
        
        Task {
            do {
                
                
                if searchType == .movies {
                    let search = try await TMDBService.shared.searchMovies(query: searchText)
                    await MainActor.run {
                        results = search
                        isLoading = false
                    }
                } else {
                    let search = try await TMDBService.shared.searchTVShows(query: searchText)
                    await MainActor.run {
                        tvResults = search
                        isLoading = false
                    }
                }
            } catch {
                await MainActor.run {
                    isLoading = false
                }
            }
        }
    }
}
