//
//  NetworkManager.swift
//  MovieExplorer
//
//  Created by YoungMin Kwon on 6/05/26.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    let baseURL = "https://api.themoviedb.org/3"
    let accessToken = Bundle.main.infoDictionary?["TMDB_ACCESS_TOKEN"] as? String ?? ""
    
    func fetch<T: Codable>(url: URL) async throws -> T {
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(T.self, from: data)
    }
}


