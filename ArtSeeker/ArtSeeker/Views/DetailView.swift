//
//  DetailView.swift
//  ArtSeeker
//
//  Created by Andres Marquez on 2022-07-07.
//

import SwiftUI

struct DetailView: View {
    let record: Result.Record
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Text(record.title)
                        .font(.title)
                        .bold()
                        .padding()
                        .multilineTextAlignment(.center)
                    
                    RecordInfoView(dated: record.dated, period: record.period, people: record.people, width: geometry.size.width, height: geometry.size.height)
                    
                    ForEach(record.images ?? [], id: \.imageid) { image in
                        VStack {
                            ImageView(
                                imageURL: image.baseimageurl,
                                imageAspectRatio: CGFloat(image.width) / CGFloat(image.height)
                            )
                            .padding()
                            
                            Text("Copyright: \(image.copyright ?? "Not available")")
                                .font(.footnote)
                                .italic()
                            
                            Spacer(minLength: 50)
                        }
                    }
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(record: ResultExample.records[0])
    }
}
