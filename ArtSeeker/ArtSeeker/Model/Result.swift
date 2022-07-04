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
}

struct Info: Codable {
    let totalrecordsperquery: Int
    let totalrecords: Int
    let pages: Int
    let page: Int
    let next: String
    var prev: String?
}

struct Record: Codable {
    let id: Int
    let primaryimageurl: URL?
    var title: String
    var period: String?
    var dated: String?
}
