//
//  Network.swift
//  ArtSeeker
//
//  Created by Andres Marquez on 2022-07-02.
//

import Foundation

struct Network {
    
    static var harvardmuseumURL = "https://api.harvardartmuseums.org/object?"
    static var recordSizeURL = "size=50&"
    static let apiKey = "apikey=6def9cd9-a933-458d-b7d0-f29c0e60a0d1"
    static var completeURL = harvardmuseumURL + recordSizeURL + apiKey
    
    enum NetworkError: Error {
        case failedToReadURL
        case failedToDecode
        case invalidStatusCode
    }
    
    func fetchResults() async throws -> Result {
        guard let url = URL(string: Network.completeURL) else {
            throw NetworkError.failedToReadURL
        }
        
        // Take the data from the URL and get the metadata in response
        let (data, response) = try await URLSession.shared.data(from: url)
            
        // Check for valid response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidStatusCode
        }

        if let decodedResponse = try? JSONDecoder().decode(Result.self, from: data) {
            return decodedResponse
        } else {
            throw NetworkError.failedToDecode
        }
    }
}
