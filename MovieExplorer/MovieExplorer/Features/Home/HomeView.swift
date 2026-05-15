import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                            .padding()
                    }
                    
                    Text("Popular Movies")
                        .font(.headline)
                        .padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.popularMovies, id: \.id) { movie in
                                NavigationLink(destination: DetailView(movie: movie)) {
                                    MovieCard(movie: movie)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    Text("Top Rated Movies")
                        .font(.headline)
                        .padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.topRatedMovies, id: \.id) { movie in
                                NavigationLink(destination: DetailView(movie: movie)) {
                                    MovieCard(movie: movie)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    Text("Popular TV Show")
                        .font(.headline)
                        .padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.popularTVShows, id: \.id) { show in
                                TVShowCard(tvShow: show)
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
}


#Preview {
    HomeView()
}
