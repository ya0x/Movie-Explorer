import Foundation

class TMDBService {
    static let shared = TMDBService()
    private init() {}
    
    func fetchPopularMovies () async throws -> [Movie] {
        let url = URL(string: NetworkManager.shared.baseURL + "/movie/popular")!
        let response: MovieResponse = try await NetworkManager.shared.fetch(url: url)
        return response.results
    }
    
    func fetchTopRatedMovies () async throws -> [Movie] {
        let url = URL(string: NetworkManager.shared.baseURL + "/movie/top_rated")!
        let response: MovieResponse = try await NetworkManager.shared.fetch(url: url)
        return response.results
    }
    
    func fetchPopularTVShows () async throws -> [TVShow] {
        let url = URL(string: NetworkManager.shared.baseURL + "/tv/popular")!
        let response: TVShowResponse = try await NetworkManager.shared.fetch(url: url)
        return response.results
    }
    
    func searchMovies(query: String) async throws -> [Movie] {
        let url = URL(string: NetworkManager.shared.baseURL + "/search/movie?query=\(query)")!
        let response: MovieResponse = try await NetworkManager.shared.fetch(url: url)
        return response.results
    }
    
    func searchTVShows(query: String) async throws -> [TVShow] {
        let url = URL(string: NetworkManager.shared.baseURL + "/search/tv?query=\(query)")!
        let response: TVShowResponse = try await NetworkManager.shared.fetch(url: url)
        return response.results
    }
}
