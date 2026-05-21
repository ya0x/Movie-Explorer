import SwiftUI
import Kingfisher

struct MovieCard: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            KFImage(URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)"))
                .placeholder { Color.gray }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(8)
                .frame(width: 120, height:180)
                .clipped()
                .accessibilityLabel("Poster of \(movie.title)")
            Text(movie.title)
                .font(.caption)
                .lineLimit(2)
                .frame(width:120)
                .multilineTextAlignment(.center)
            Text("⭐\(String(format: "%.1f", movie.voteAverage))")
                .font(.caption2)
            Text(String((movie.releaseDate).prefix(4)))
                .font(.caption2)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    MovieCard(movie: Movie(
        id: 1,
        title: "Inception",
        overview: "A thief who...",
        posterPath: "/abc123.jpg",
        voteAverage: 8.5,
        releaseDate: "2010-07-16"
    ))
}
