import Foundation

struct TVShowDTO: Codable {
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

struct TVShow {
    let id: Int
    let name: String
    let overview: String
    let posterPath: String
    let voteAverage: Double
    let firstAirDate: String
}

extension TVShowDTO {
    func toDomain() -> TVShow {
        return TVShow(id: id, name: name, overview: overview, posterPath: posterPath, voteAverage: voteAverage, firstAirDate: firstAirDate)
    }
}

struct Season: Codable {
    let airdate: String?
    let episodeCount: Int
    let id: Int
    let name: String
    let overview: String?
    let posterPath: String
    let seasonNumber: Int
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case airdate
        case episodeCount = "episode_count"
        case id
        case name
        case overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
        case voteAverage = "vote_average"
    }
}

struct Episode: Codable {
    let id: Int
    let name: String
    let overview: String?
    let episodeNumber: Int
    let runtime: Int?
    let airDate: String?
    let stillPath: String?
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case episodeNumber = "episode_number"
        case runtime
        case airDate = "air_date"
        case stillPath = "still_path"
        case voteAverage = "vote_average"
    }
}

struct SeasonDetail: Codable {
    let id: Int
    let name: String
    let overview: String?
    let seasonNumber: Int
    let episodes: [Episode]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case seasonNumber = "season_number"
        case episodes
    }
}

struct TVShowDetail: Codable {
    let id: Int
    let name: String
    let overview: String
    let posterPath: String?
    let voteAverage: Double
    let firstAirDate: String
    let genres: [Genre]
    let numberOfSeasons: Int
    let seasons: [Season]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case firstAirDate = "first_air_date"
        case genres
        case numberOfSeasons = "number_of_seasons"
        case seasons
    }
}

struct TVShowResponse: Codable {
    let results: [TVShowDTO]
}
