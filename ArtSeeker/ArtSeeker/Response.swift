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
    //var prev: String
}

struct Record: Codable {
    var id: Int
    var images: [Image]
}

struct Image: Codable {
    //var date: String?
    //var copyright: String?
    var imageid: Int
    //"idsid":45605888,"format":"image/jpeg","description":null,"technique":null,"renditionnumber":"STR009286","displayorder":1,
    //var baseimageurl: String
    //,"alttext":null,"width":822,"publiccaption":null,"iiifbaseuri":"https://ids.lib.harvard.edu/ids/iiif/45605888","height":1024}
}
