import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        VStack {
            TextField("Seach movies...", text: $viewModel.searchText)
            
            Picker("Search Type", selection: $viewModel.searchType) {
                Text("Movies").tag(SearchViewModel.SearchType.movies)
                Text("TV Shows").tag(SearchViewModel.SearchType.tvShows)
            }
            .pickerStyle(.segmented)
            
            if viewModel.isLoading {
                ProgressView("Searching...")
                    .padding()
            }
            
            if !viewModel.errorMessage.isEmpty {
                VStack {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                    Button("Retry") {
                        viewModel.search()
                    }
                }
                .padding()
            }
            
            if !viewModel.isLoading && !viewModel.searchText.isEmpty {
                if viewModel.searchType == .movies && viewModel.results.isEmpty {
                    Text("No results found.")
                        .foregroundColor(.gray)
                        .padding()
                } else if viewModel.searchType == .tvShows && viewModel.tvResults.isEmpty {
                    Text("No results found.")
                        .foregroundColor(.gray)
                        .padding()
                }
                
            }
            
            List {
                if viewModel.searchType == .movies {
                    ForEach(viewModel.results, id: \.id) { movie in
                        MovieCard(movie: movie)
                    }
                } else {
                    ForEach(viewModel.tvResults, id: \.id) { show in
                        TVShowCard(tvShow: show)
                    }
                }
                
            }
        }
    }
}

#Preview {
    SearchView()
}
