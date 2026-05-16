import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        VStack {
            TextField("Seach movies...", text: $viewModel.searchText)
                .onSubmit {
                    viewModel.search()
                }
            
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
            
            if !viewModel.isLoading && viewModel.results.isEmpty && !viewModel.searchText.isEmpty {
                Text("No results found.")
                    .foregroundColor(.gray)
                    .padding()
            }
            
            List {
                ForEach(viewModel.results, id: \.id) { movie in
                    MovieCard(movie: movie)
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
