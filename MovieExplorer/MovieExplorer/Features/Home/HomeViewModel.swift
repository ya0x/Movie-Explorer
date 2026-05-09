import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var popularMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []
    @Published var popularTVShows: [TVShow] = []
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    func loadData() {
        isLoading = true
        
        Task {
            do {
                let movies = try await TMDBService.shared.fetchPopularMovies()
                let topRated = try await TMDBService.shared.fetchTopRatedMovies()
                let shows = try await TMDBService.shared.fetchPopularTVShows()
                
                await MainActor.run {
                    popularMovies = movies
                    topRatedMovies = topRated
                    popularTVShows = shows
                    isLoading = false
                }
            } catch {
                await MainActor.run {
                    errorMessage = "Failed to load data."
                    isLoading = false
                }
            }
        }
    }
}
