import SwiftUI

struct DetailView: View {
    let movie: Movie
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 4) {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(8)
                } placeholder: {
                    Color.gray
                }
                .frame(width: 300, height:450)
                .clipped()
                Text(movie.title)
                    .font(.title)
                Text("⭐\(String(format: "%.1f", movie.voteAverage))")
                    .font(.caption2)
                Text(movie.overview)
                    .padding()
            }
        }
    }
}

#Preview {
    DetailView(movie: Movie(
        id: 1,
        title: "Inception",
        overview: "A thief who...",
        posterPath: "/abc123.jpg",
        voteAverage: 8.5,
        releaseDate: "2010-07-16"
    ))
}
