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
                            .accessibilityLabel("Retry loading content")
                        }
                        .padding()
                    } else if viewModel.isLoading {
                        ProgressView("Loading...")
                            .padding()
                    } else {
                        
                        Text("home.trending.title")
                            .font(.headline)
                            .padding(.horizontal)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.trendingMovies, id: \.id) { movie in
                                    NavigationLink(destination: DetailView(movieID: movie.id)) {
                                        MovieCard(movie: movie)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        Text("home.popular.title")
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
                        
                        Text("home.topRated.title")
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
                        
                        Text("home.popularTV.title")
                            .font(.headline)
                            .padding(.horizontal)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.popularTVShows, id: \.id) { show in
                                    NavigationLink(destination: TVShowDetailView(tvShowID: show.id)) {
                                        TVShowCard(tvShow: show)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    
                }
            }
            .onAppear {
                viewModel.loadData()
            }
            .navigationTitle("Movie Explorer")
        }
    }
}


#Preview {
    HomeView()
}
