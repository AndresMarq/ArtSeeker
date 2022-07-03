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
    //var prev: String
}

struct Record: Codable {
    let id: Int
    let primaryimageurl: URL?
    var title: String
    //var images: [Image]
}

//struct Image: Codable {
    //var date: String?
    //var copyright: String?
    //var imageid: Int
    //"idsid":45605888,"format":"image/jpeg","description":null,"technique":null,"renditionnumber":"STR009286","displayorder":1,
    //var baseimageurl: String
    //,"alttext":null,"width":822,"publiccaption":null,"iiifbaseuri":"https://ids.lib.harvard.edu/ids/iiif/45605888","height":1024}
//}
