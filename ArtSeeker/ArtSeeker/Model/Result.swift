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
        let totalrecordsperquery: Int
        let totalrecords: Int
        let pages: Int
        let page: Int
        let next: String
        let prev: String?
    }
    
    struct Record: Codable {
        let id: Int
        let primaryimageurl: URL?
        let title: String
        let imagecount: Int
        let period: String?
        let dated: String?
        let images: [Image]?
        
        struct Image: Codable {
            let imageid: Int
            let description: String?
            let baseimageurl: URL?
            let width: Int
            let height: Int
        }
    }
}
