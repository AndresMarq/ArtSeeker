//
//  ListView.swift
//  ArtSeeker
//
//  Created by Andres Marquez on 2022-07-11.
//

import SwiftUI

struct ListView: View {
    let data: [Result.Record]
    
    var body: some View {
        GeometryReader { geometry in
            List(data, id: \.id) { record in
                NavigationLink(destination: DetailView(record: record)) {
                    HStack {
                        ImageView(
                            imageURL: record.images?.first?.baseimageurl,
                            imageAspectRatio: CGFloat(record.images?.first?.width ?? 1) / CGFloat(record.images?.first?.height ?? 1)
                        )
                            .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.3)
                        Spacer()
                        VStack {
                            Text(record.title)
                                .font(.caption)
                                .bold()
                                .padding(.bottom, 1.0)
                            Text("Dated: \(record.dated ?? "Not available")")
                                .font(.caption2)
                        }
                        .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.3)
                        .multilineTextAlignment(.center)
                    }
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(data: ResultExample.records)
    }
}
