import Foundation

struct CastMember: Codable {
    let id: Int
    let name: String
    let character: String
    let profilePath: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case character
        case profilePath = "profile_path"
    }
}

struct CreditsResponse: Codable {
    let cast: [CastMember]
}
