//
//  ImageView.swift
//  ArtSeeker
//
//  Created by Andres Marquez on 2022-07-03.
//

import SwiftUI

struct ImageView: View {
    let imageURL: URL?
    let imageAspectRatio: CGFloat
    
    var body: some View {
        AsyncImage(url: imageURL) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case . success(let image):
                ZStack {
                    Rectangle()
                        .fill(Color.clear)
                        .aspectRatio(imageAspectRatio, contentMode: .fit)
                    
                    image.resizable()
                        .scaledToFit()
                        .layoutPriority(-1)
                }
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
            case .failure:
                Image(systemName: "photo")
            @unknown default:
                // Unused fallback to handle new cases which may be added in the future
                Text("")
            }
        }
        .accessibilityHidden(true)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(imageURL: URL(string: "https://nrs.harvard.edu/urn-3:HUAM:LEG256541")!, imageAspectRatio: 1)
    }
}
