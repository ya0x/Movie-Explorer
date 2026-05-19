import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var popularMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []
    @Published var trendingMovies: [Movie] = []
    @Published var popularTVShows: [TVShow] = []
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    func loadData() {
        errorMessage = ""
        isLoading = true
        
        Task {
            do {
                let movies = try await TMDBService.shared.fetchPopularMovies()
                let topRated = try await TMDBService.shared.fetchTopRatedMovies()
                let trending = try await TMDBService.shared.fetchTrendingMovies()
                let shows = try await TMDBService.shared.fetchPopularTVShows()
                
                await MainActor.run {
                    popularMovies = movies
                    topRatedMovies = topRated
                    trendingMovies = trending
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
