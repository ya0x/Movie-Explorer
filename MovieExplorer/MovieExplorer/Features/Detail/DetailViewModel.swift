import Foundation
import Combine

class DetailViewModel: ObservableObject {
    @Published var movieDetail: MovieDetail?
    @Published var cast: [CastMember] = []
    @Published var videos: [Video] = []
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    func loadDetail(id: Int) {
        isLoading = true
        
        Task {
            do {
                let movieDetails = try await TMDBService.shared.fetchMovieDetail(id: id)
                let credit = try await TMDBService.shared.fetchMovieCredits(id: id)
                let video = try await TMDBService.shared.fetchMovieVideos(id: id)
                
                await MainActor.run {
                    movieDetail = movieDetails
                    cast = credit.cast
                    videos = video.results
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
