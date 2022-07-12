//
//  ExploreView.swift
//  ArtSeeker
//
//  Created by Andres Marquez on 2022-07-03.
//

import SwiftUI

struct ExploreView: View {
    var body: some View {
        ImageView(imageURL: URL(string: "https://nrs.harvard.edu/urn-3:HUAM:DDC255075"), imageAspectRatio: CGFloat(0.75))
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
