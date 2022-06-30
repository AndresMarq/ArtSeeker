//
//  Response.swift
//  ArtSeeker
//
//  Created by Andres Marquez on 2022-06-29.
//

import Foundation

let harvardmuseumURL = "https://api.harvardartmuseums.org/object?apikey="
let apiKey = "6def9cd9-a933-458d-b7d0-f29c0e60a0d1"
let completeURL = harvardmuseumURL + apiKey

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var info: Info
    var records: [Record]
}

struct Info: Codable {
    var totalrecordsperquery: Int
    var totalrecords: Int
    var pages: Int
    var page: Int
    var next: String
    var prev: String
}

struct Record: Codable {
    var id: Int
    var imageid: Int
    var fileid: Int
    var idsid: Int
    var caption: String
    var alttext: String
    var description: String
    var copyright: String
    var iiifbaseuri: String
    var baseimageurl: String
    var renditionnumber: Int
    var date: String
    var height: Int
    var width: Int
    var accesslevel: Int
    var format: String
    var technique: String
}
