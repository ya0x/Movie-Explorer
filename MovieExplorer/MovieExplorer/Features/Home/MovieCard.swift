import SwiftUI

struct MovieCard: View {
    let movie: Movie
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray
            }
            .frame(width: 120, height:180)
            .clipped()
            Text(movie.title)
            Text(String(movie.voteAverage))
        }
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
