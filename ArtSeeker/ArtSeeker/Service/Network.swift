//
//  Network.swift
//  ArtSeeker
//
//  Created by Andres Marquez on 2022-07-02.
//

import Foundation

struct Network {
    
    // MARK: -URLs
    static let harvardmuseumURL = "https://api.harvardartmuseums.org/object?"
    static var recordSizeURL = "size=15&"
    static let apiKey = "&apikey=6def9cd9-a933-458d-b7d0-f29c0e60a0d1"
    
    // Filter
    // This parameter should discard records without images
    static let hasImageURL = "hasimage=1&"
    // This parameter searches object titles, artists, description, classification, culture, and worktype
    static var keywordFilterURL = "keyword="
    
    // Page number
    static let pageTemplateURL = "&page="
    static var pageNumberURL = "1"
    
    // MARK: -Errors
    enum NetworkError: Error {
        case failedToReadURL
        case failedToDecode
        case invalidStatusCode
    }
    
    // MARK: -Fetch Request
    func fetchResults() async throws -> Result {
        
        // Get the desired result URL page
        let pageURL = Network.pageTemplateURL + Network.pageNumberURL
        
        // URL used for fetch request
        let completeURL = Network.harvardmuseumURL + Network.recordSizeURL + Network.hasImageURL + Network.keywordFilterURL + pageURL + Network.apiKey
        
        guard let url = URL(string: completeURL) else {
            print(completeURL)
            throw NetworkError.failedToReadURL
        }
        
        // Take the data from the URL and get the metadata in response
        let (data, response) = try await URLSession.shared.data(from: url)
            
        // Check for valid response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidStatusCode
        }

        if let decodedResponse = try? JSONDecoder().decode(Result.self, from: data) {
            print(completeURL)
            return decodedResponse
        } else {
            throw NetworkError.failedToDecode
        }
    }
    
    // MARK: - Change Result Page Number
    mutating func changeResultPageNumber(pageNumber: String) {
        Network.pageNumberURL = pageNumber
    }
    
    // MARK: - Filter fetch by keyword
    mutating func filterByKeyword(keyword: String) {
        Network.keywordFilterURL = "keyword=" + keyword
    }
}
