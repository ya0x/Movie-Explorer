import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var popularMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []
    @Published var trendingMovies: [Movie] = []
    @Published var popularTVShows: [TVShow] = []
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    private let service: TMDBServiceProtocol
    
    init(service: TMDBServiceProtocol = TMDBService.shared) {
        self.service = service
    }
    
    func loadData() {
        errorMessage = ""
        isLoading = true
        
        Task {
            do {
                let movies = try await service.fetchPopularMovies()
                let topRated = try await service.fetchTopRatedMovies()
                let trending = try await service.fetchTrendingMovies()
                let shows = try await service.fetchPopularTVShows()
                
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
