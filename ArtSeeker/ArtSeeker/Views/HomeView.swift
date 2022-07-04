//
//  HomeView.swift
//  ArtSeeker
//
//  Created by Andres Marquez on 2022-07-03.
//

import SwiftUI

struct HomeView: View {
    let data: Result
    
    var body: some View {
        GeometryReader { geometry in
            List(data.records, id: \.id) { record in
                VStack {
                    ImageView(imageURL: record.primaryimageurl)
                    Text(record.title)
                }
            }
        }
        .navigationTitle("Art Seeker")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(data: Result(info: Info(totalrecordsperquery: 0, totalrecords: 0, pages: 0, page: 0, next: ""), records: []))
    }
}
