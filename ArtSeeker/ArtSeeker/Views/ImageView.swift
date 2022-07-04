//
//  ImageView.swift
//  ArtSeeker
//
//  Created by Andres Marquez on 2022-07-03.
//

import SwiftUI

struct ImageView: View {
    let imageURL: URL?
    
    var body: some View {
        AsyncImage(
            url: imageURL,
            content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
            }, placeholder: {
                LoadingView()
            }
        )
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(imageURL: URL(string: "https://nrs.harvard.edu/urn-3:HUAM:LEG256541")!)
    }
}
