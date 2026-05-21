import SwiftUI
import Kingfisher

struct TVShowDetailView: View {
    @StateObject private var viewModel = TVShowDetailViewModel()
    let tvShowID: Int
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 4) {
                KFImage(URL(string: "https://image.tmdb.org/t/p/w500\(viewModel.tvShowDetail?.posterPath ?? "")"))
                    .placeholder { Color.gray }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(8)
                    .frame(width: 300, height:450)
                    .clipped()
                    .accessibilityLabel("Poster of \(viewModel.tvShowDetail?.name ?? "")")
                
                Text(viewModel.tvShowDetail?.name ?? "")
                    .font(.title)
                
                Text(String((viewModel.tvShowDetail?.firstAirDate ?? "").prefix(4)))
                    .font(.caption2)
                
                Text("⭐\(String(format: "%.1f", viewModel.tvShowDetail?.voteAverage ?? 0.0))")
                    .font(.caption2)
                
                Text(viewModel.tvShowDetail?.overview ?? "")
                    .padding()
                
                Text("\(String(localized: "detail.seasons.title")): \(viewModel.tvShowDetail?.numberOfSeasons ?? 0) temporadas")
                    .font(.caption)
                
                HStack {
                    ForEach(viewModel.tvShowDetail?.genres ?? [], id: \.id) { genre in
                        Text(genre.name)
                            .font(.caption)
                            .padding(4)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(4)
                    }
                }
                
                Text("detail.seasons.title")
                    .font(.headline)
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.tvShowDetail?.seasons ?? [], id: \.id) { season in
                            NavigationLink(destination: SeasonDetailView(tvShowID: tvShowID, seasonNumber: season.seasonNumber)) {
                                VStack {
                                    KFImage(URL(string: "https://image.tmdb.org/t/p/w500\(season.posterPath)"))
                                        .placeholder { Color.gray }
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .cornerRadius(8)
                                        .frame(width: 120, height:180)
                                        .clipped()
                                    
                                    Text(season.name)
                                        .font(.caption)
                                        .lineLimit(2)
                                        .frame(width:120)
                                        .multilineTextAlignment(.center)
                                    
                                    Text("\(season.episodeCount) episodes")
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
                
                Text("detail.cast.title")
                    .font(.headline)
                
                ForEach(viewModel.cast.prefix(5), id: \.id) { member in
                    Text("\(member.name) as \(member.character ?? "")")
                        .font(.caption)
                }
                
                Text("detail.trailers.title")
                    .font(.headline)
                
                ForEach(viewModel.videos.filter { $0.site == "YouTube" && $0.type == "Trailer" }, id: \.key) { video in
                    YoutubePlayerView(videoKey: video.key)
                        .frame(height: 200)
                }
                
                Text("detail.recommended.title")
                    .font(.headline)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.recommended, id: \.id) { show in
                            NavigationLink(destination: TVShowDetailView(tvShowID: show.id)) {
                                TVShowCard(tvShow: show)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadDetail(id: tvShowID)
        }
    }
}

#Preview {
    TVShowDetailView(tvShowID: 550)
}
