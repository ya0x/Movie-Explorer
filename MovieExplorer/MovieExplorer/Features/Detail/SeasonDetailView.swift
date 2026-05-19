import SwiftUI
import Kingfisher

struct SeasonDetailView: View {
    @StateObject private var viewModel: SeasonDetailViewModel
    
    let tvShowID: Int
    let seasonNumber: Int
    
    init(tvShowID: Int, seasonNumber: Int) {
        self.tvShowID = tvShowID
        self.seasonNumber = seasonNumber
        _viewModel = StateObject(wrappedValue: SeasonDetailViewModel())
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 4) {
                Text(viewModel.seasonDetail?.name ?? "")
                    .font(.title)
                
                ForEach(viewModel.seasonDetail?.episodes ?? [], id: \.id) { episode in
                    VStack(spacing: 4) {
                        KFImage(URL(string: "https://image.tmdb.org/t/p/w500\(episode.stillPath ?? "")"))
                            .placeholder { Color.gray }
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(8)
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(episode.episodeNumber). \(episode.name)")
                            Text("\(episode.runtime ?? 0) min")
                            Text(episode.overview ?? "")
                        }
                    }
                }
            }
            .onAppear {
                viewModel.loadSeason(tvShowID: tvShowID, seasonNumber: seasonNumber)
            }
        }
    }
}
