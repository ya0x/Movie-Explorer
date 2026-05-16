import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    if !viewModel.errorMessage.isEmpty {
                        VStack {
                            Text(viewModel.errorMessage)
                                .foregroundColor(.red)
                            Button("Retry") {
                                viewModel.loadData()
                            }
                        }
                        .padding()
                    } else if viewModel.isLoading {
                        ProgressView("Loading...")
                            .padding()
                    } else {
                        
                        Text("Popular Movies")
                            .font(.headline)
                            .padding(.horizontal)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.popularMovies, id: \.id) { movie in
                                    NavigationLink(destination: DetailView(movieID: movie.id)) {
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
                                    NavigationLink(destination: DetailView(movieID: movie.id)) {
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
