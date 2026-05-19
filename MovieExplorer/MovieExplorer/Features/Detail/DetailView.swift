import SwiftUI
import Kingfisher

struct DetailView: View {
    @StateObject private var viewModel = DetailViewModel()
    let movieID: Int
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 4) {
                KFImage(URL(string: "https://image.tmdb.org/t/p/w500\(viewModel.movieDetail?.posterPath ?? "")"))
                    .placeholder { Color.gray }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(8)
                    .frame(width: 300, height:450)
                    .clipped()
                
                Text(viewModel.movieDetail?.title ?? "")
                    .font(.title)
                
                Text(String((viewModel.movieDetail?.releaseDate ?? "").prefix(4)))
                    .font(.caption2)
                
                Text("⭐\(String(format: "%.1f", viewModel.movieDetail?.voteAverage ?? 0.0))")
                    .font(.caption2)
                
                Text(viewModel.movieDetail?.overview ?? "")
                    .padding()
                
                Text("Runtime: \(viewModel.movieDetail?.runtime ?? 0) min")
                    .font(.caption)
                
                HStack {
                    ForEach(viewModel.movieDetail?.genres ?? [], id: \.id) { genre in
                        Text(genre.name)
                            .font(.caption)
                            .padding(4)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(4)
                    }
                }
                
                Text("Cast")
                    .font(.headline)
                
                ForEach(viewModel.cast.prefix(5), id: \.id) { member in
                    Text("\(member.name) as \(member.character ?? "")")
                        .font(.caption)
                }
                
                Text("Trailers")
                    .font(.headline)
                
                ForEach(viewModel.videos.filter { $0.site == "YouTube" && $0.type == "Trailer" }, id: \.key) { video in
                    YoutubePlayerView(videoKey: video.key)
                        .frame(height: 200)
                }
                
                Text("Recommended")
                    .font(.headline)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.recommended, id: \.id) { movie in
                            NavigationLink(destination: DetailView(movieID: movie.id)) {
                                MovieCard(movie: movie)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadDetail(id: movieID)
        }
    }
}

#Preview {
    DetailView(movieID: 550)
}
