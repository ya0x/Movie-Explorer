import Foundation

protocol TMDBServiceProtocol {
    func fetchPopularMovies() async throws -> [Movie]
    func fetchTopRatedMovies() async throws -> [Movie]
    func fetchTrendingMovies() async throws -> [Movie]
    func fetchPopularTVShows() async throws -> [TVShow]
}
