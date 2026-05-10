import SwiftUI

struct TVShowCard: View {
    let tvShow: TVShow
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(tvShow.posterPath)")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(8)
            } placeholder: {
                Color.gray
            }
            .frame(width: 120, height:180)
            .clipped()
            Text(tvShow.name)
                .font(.caption)
                .lineLimit(2)
                .frame(width:120)
                .multilineTextAlignment(.center)
            Text("⭐\(String(format: "%.1f", tvShow.voteAverage))")
                .font(.caption2)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    TVShowCard(tvShow: TVShow(
        id: 1,
        name: "Inception",
        overview: "A thief who...",
        posterPath: "/abc123.jpg",
        voteAverage: 8.5,
        firstAirDate: "2010-07-16"
    ))
}
