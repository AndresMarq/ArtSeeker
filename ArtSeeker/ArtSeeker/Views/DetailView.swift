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
        ScrollView {
            VStack {
                Text(record.title)
                    .bold()
                    .padding()
                    .multilineTextAlignment(.center)
                
                ForEach(record.images ?? [], id: \.imageid) { image in
                    ImageView(
                        imageURL: image.baseimageurl,
                        imageAspectRatio: CGFloat(image.width) / CGFloat(image.height)
                    )
                    .padding()
                }
            }
        }
        .onAppear(perform: printRecord)
    }
    
    func printRecord() {
        print(record)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(record: ResultExample.records[0])
    }
}
