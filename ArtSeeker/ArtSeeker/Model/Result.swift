//
//  Response.swift
//  ArtSeeker
//
//  Created by Andres Marquez on 2022-06-29.
//

import Foundation

struct Result: Codable {
    let info: Info
    let records: [Record]
    
    struct Info: Codable {
        let totalRecordsPerQuery: Int
        let totalRecords: Int
        let pages: Int
        let page: Int
        
        enum CodingKeys: String, CodingKey {
            case totalRecordsPerQuery = "totalrecordsperquery"
            case totalRecords = "totalrecords"
            case pages
            case page
        }
    }
    
    struct Record: Codable {
        let id: Int
        let primaryImageUrl: URL?
        let title: String
        let imageCount: Int
        let period: String?
        let dated: String?
        let images: [Image]?
        let people: [Person]?
        
        enum CodingKeys: String, CodingKey {
            case id
            case primaryImageUrl = "primaryimageurl"
            case title
            case imageCount = "imagecount"
            case period
            case dated
            case images
            case people
        }
        
        struct Image: Codable {
            let imageId: Int
            let description: String?
            let baseImageUrl: URL?
            let width: Int
            let height: Int
            let copyright: String?
            let date: String?
            
            enum CodingKeys: String, CodingKey {
                case imageId = "imageid"
                case description
                case baseImageUrl = "baseimageurl"
                case width
                case height
                case copyright
                case date
            }
        }
        
        struct Person: Codable {
            let birthplace: String?
            let name: String
            let personId: Int
            
            enum CodingKeys: String, CodingKey {
                case birthplace
                case name
                case personId = "personid"
            }
        }
    }
}
