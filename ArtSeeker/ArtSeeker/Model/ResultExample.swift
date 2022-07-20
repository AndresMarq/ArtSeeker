//
//  ResultExample.swift
//  ArtSeeker
//
//  Created by Andres Marquez on 2022-07-05.
//

import Foundation

let ResultExample = Result(
    info:
        Result.Info(
            totalRecordsPerQuery: 2,
            totalRecords: 240079,
            pages: 120039,
            page: 1
        ),
    records: [
        Result.Record(
            id: 74101,
            primaryImageUrl: URL(string: "https://nrs.harvard.edu/urn-3:HUAM:LEG256541"),
            title: "Seal of Philommates patrikios, imperial protospatharios and strategos of the Armeniakoi (IX/X c.)",
            imageCount: 2,
            period: "Byzantine period",
            dated: "IX/X c.",
            images: [Result.Record.Image(
                imageId: 459499,
                description: nil,
                baseImageUrl: URL(string: "https://nrs.harvard.edu/urn-3:HUAM:LEG256541"),
                width: 2550,
                height: 897,
                copyright: Optional("President and Fellows of Harvard College"),
                date: Optional("2016-01-15")
                     ),
                     Result.Record.Image(
                        imageId: 47424,
                        description: nil,
                        baseImageUrl: URL(string: "https://nrs.harvard.edu/urn-3:HUAM:COIN20379_dlvr"),
                        width: 1024,
                        height: 478,
                        copyright: "President and Fellows of Harvard College",
                        date: "2005-09-26"
                     )
            ],
            people: [
                Result.Record.Person(
                    birthplace: "Maracaibo",
                    name: "Raphael",
                    personId: 10
                )
            ]
        ),
        
        Result.Record(
            id: 74114,
            primaryImageUrl: URL(string: "https://nrs.harvard.edu/urn-3:HUAM:LEG256562"),
            title: "Seal of N., protospatharios, thesmophylax, and judge of the Thrakesioi (X/XI c.)",
            imageCount: 2,
            period: nil,
            dated: "X/XI c.",
            images: [
                Result.Record.Image(
                    imageId: 459520,
                    description: nil,
                    baseImageUrl: URL(string: "https://nrs.harvard.edu/urn-3:HUAM:LEG256562"),
                    width: 2550,
                    height: 899,
                    copyright: "President and Fellows of Harvard College",
                    date: "2016-01-15"
                ),
                Result.Record.Image(
                    imageId: 146156,
                    description: nil,
                    baseImageUrl: URL(string: "https://nrs.harvard.edu/urn-3:HUAM:COIN20397_dlvr"),
                    width: 1024,
                    height: 478,
                    copyright: "President and Fellows of Harvard College",
                    date: "2005-09-26"
                )
            ],
        people: []
        )
    ])
