import SwiftUI
import Kingfisher

struct TVShowCard: View {
    let tvShow: TVShow
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            KFImage(URL(string: "https://image.tmdb.org/t/p/w500\(tvShow.posterPath)"))
                .placeholder { Color.gray }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(8)
                .frame(width: 120, height:180)
                .clipped()
                .accessibilityLabel("Poster of \(tvShow.name)")
            Text(tvShow.name)
                .font(.caption)
                .lineLimit(2)
                .frame(width:120)
                .multilineTextAlignment(.center)
            HStack {
                Text(String((tvShow.firstAirDate).prefix(4)))
                    .font(.caption2)
                    .padding(4)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(4)
                Text("⭐\(String(format: "%.1f", tvShow.voteAverage))")
                    .font(.caption2)
                    .padding(4)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(4)
            }
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
