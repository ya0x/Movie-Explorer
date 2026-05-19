import Foundation
import Combine

class SeasonDetailViewModel: ObservableObject {
    @Published var seasonDetail: SeasonDetail?
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    func loadSeason(tvShowID: Int, seasonNumber: Int) {
        isLoading = true
        
        Task {
            do {
                let seasonDetails = try await TMDBService.shared.fetchSeasonDetail(tvShowId: tvShowID, seasonNumber: seasonNumber)
                
                await MainActor.run {
                    seasonDetail = seasonDetails
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
