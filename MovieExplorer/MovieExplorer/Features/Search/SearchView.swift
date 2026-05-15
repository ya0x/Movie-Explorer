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
