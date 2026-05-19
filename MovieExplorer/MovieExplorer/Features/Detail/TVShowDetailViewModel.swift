import Foundation
import Combine

class TVShowDetailViewModel: ObservableObject {
    @Published var tvShowDetail: TVShowDetail?
    @Published var cast: [CastMember] = []
    @Published var videos: [Video] = []
    @Published var recommended: [TVShow] = []
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    func loadDetail(id: Int) {
        isLoading = true
        
        Task {
            do {
                let tvDetail = try await TMDBService.shared.fetchTVShowDetail(id: id)
                let credit = try await TMDBService.shared.fetchTVShowCredits(id: id)
                let video = try await TMDBService.shared.fetchTVShowVideos(id: id)
                let recommendedTVShows = try await TMDBService.shared.fetchTVShowRecommendations(id: id)
                
                await MainActor.run {
                    tvShowDetail = tvDetail
                    cast = credit.cast
                    videos = video.results
                    recommended = recommendedTVShows
                    isLoading = false
                }
            } catch {
                await MainActor.run {
                    errorMessage = error.localizedDescription
                    isLoading = false
                }
            }
        }
    }
}
