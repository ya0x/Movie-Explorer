import XCTest
@testable import MovieExplorer

class MockTMDBService: TMDBServiceProtocol {
    func fetchPopularMovies() async throws -> [Movie] {
        return [Movie(id: 1, title: "Mock Movie", overview: "Overview", posterPath: "/test.jpg", voteAverage: 8.0, releaseDate: "2024")]
    }
    func fetchTopRatedMovies() async throws -> [Movie] {
        return []
    }
    func fetchTrendingMovies() async throws -> [Movie] {
        return []
    }
    func fetchPopularTVShows() async throws -> [TVShow] {
        return []
    }
}

class MockTMDBServiceError: TMDBServiceProtocol {
    func fetchPopularMovies() async throws -> [Movie] {
        throw NSError(domain: "TestError", code: 0)
    }
    func fetchTopRatedMovies() async throws -> [Movie] {
        throw NSError(domain: "TestError", code: 0)
    }
    func fetchTrendingMovies() async throws -> [Movie] {
        throw NSError(domain: "TestError", code: 0)
    }
    func fetchPopularTVShows() async throws -> [TVShow] {
        throw NSError(domain: "TestError", code: 0)
    }
}

final class MovieExplorerTests: XCTestCase {
    func testMovieDecoding() throws {
        let json = """
            {
            
            "id": 1,
            "title": "Test Movie",
            "overview": "Test Overview",
            "poster_path": "Test posterpath",
            "vote_average": 1,
            "release_date": "2026"
        }            
        """
        let data = Data(json.utf8)
        let decoder = JSONDecoder()
        let movie = try decoder.decode(Movie.self, from: data)
        
        XCTAssertEqual(movie.id, 1)
        XCTAssertEqual(movie.title, "Test Movie")
        XCTAssertEqual(movie.posterPath, "Test posterpath")
        XCTAssertEqual(movie.voteAverage, 1)
        XCTAssertEqual(movie.releaseDate, "2026")
    }
    
    func testTVShowDecoding() throws {
        let json = """
            {
            
            "id": 1,
            "name": "Test Movie",
            "overview": "Test Overview",
            "poster_path": "Test posterpath",
            "vote_average": 1,
            "first_air_date": "2026"
        }            
        """
        let data = Data(json.utf8)
        let decoder = JSONDecoder()
        let tvShow = try decoder.decode(TVShow.self, from: data)
        
        XCTAssertEqual(tvShow.id, 1)
        XCTAssertEqual(tvShow.name, "Test Movie")
        XCTAssertEqual(tvShow.posterPath, "Test posterpath")
        XCTAssertEqual(tvShow.voteAverage, 1)
        XCTAssertEqual(tvShow.firstAirDate, "2026")
        
    }
    
    @MainActor
    func testHomeViewModelLoadData() async throws {
        let mockService = MockTMDBService()
        let viewModel = HomeViewModel(service: mockService)
        
        viewModel.loadData()
        
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        XCTAssertEqual(viewModel.popularMovies.count, 1)
        XCTAssertEqual(viewModel.popularMovies.first?.title, "Mock Movie")
    }
    
    @MainActor
    func testServiceError() async throws {
        let mockService = MockTMDBServiceError()
        let viewModel = HomeViewModel(service: mockService)
        
        viewModel.loadData()
        
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        XCTAssertFalse(viewModel.errorMessage.isEmpty)
    }
}
