import Foundation

struct Video: Codable {
    let key: String
    let name: String
    let type: String
    let site: String
}

struct VideoResponse: Codable {
    let results: [Video]
}
