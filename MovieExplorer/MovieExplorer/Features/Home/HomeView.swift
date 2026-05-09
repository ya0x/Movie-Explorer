import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                Text("Popular Movies")
                    .font(.headline)
                    .padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.popularMovies, id: \.id) { movie in
                            Text(movie.title)
                        }
                    }
                    .padding(.horizontal)
                }
                
                Text("Top Rated Movies")
                    .font(.headline)
                    .padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.topRatedMovies, id: \.id) { movie in
                            Text(movie.title)
                        }
                    }
                    .padding(.horizontal)
                }
                
                Text("Popular TV Show")
                    .font(.headline)
                    .padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.popularTVShows, id: \.id) { show in
                            Text(show.name)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .onAppear {
            viewModel.loadData()
        }
    }
}

#Preview {
    HomeView()
}
