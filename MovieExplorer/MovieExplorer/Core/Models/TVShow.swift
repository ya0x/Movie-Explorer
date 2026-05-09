import Foundation

struct TVShow: Codable {
    let id: Int
    let name: String
    let overview: String
    let posterPath: String
    let voteAverage: Double
    let firstAirDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case firstAirDate = "first_air_date"
    }
}

struct TVShowResponse: Codable {
    let results: [TVShow]
}
