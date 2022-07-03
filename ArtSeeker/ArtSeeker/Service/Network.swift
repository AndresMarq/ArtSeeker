//
//  Network.swift
//  ArtSeeker
//
//  Created by Andres Marquez on 2022-07-02.
//

import Foundation

struct Network {
    
    enum NetworkError: Error {
        case failed
        case failedToDecode
        case invalidStatusCode
    }
    
    func fetchResults() async throws -> Result {
        let url = URL(string: completeURL)!
        
        // Take the data from the URL and get the metadata in response
        let (data, response) = try await URLSession.shared.data(from: url)
            
        // Check for valid response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidStatusCode
        }

        let decodedResponse = try JSONDecoder().decode(Result.self, from: data)
            
        return decodedResponse
    }
}
