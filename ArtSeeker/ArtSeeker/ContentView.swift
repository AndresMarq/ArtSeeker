//
//  ContentView.swift
//  ArtSeeker
//
//  Created by Andres Marquez on 2022-06-28.
//

import SwiftUI

struct ContentView: View {
    @State private var records = [Record]()
    
    var body: some View {
        List(records, id: \.id) { record in
            Text("\(record.id)")
            //List(record.images, id: \.imageid) { image in
            //    AsyncImage(url: URL(string: image.baseimageurl))
            //}
            
        }
        .task {
            await loadData()
        }
    }
    
    // Move out of the view
    func loadData() async {
        guard let url = URL(string: completeURL) else {
            print("Invalid URL")
            return
        }
        
        do {
            // Take the data from the URL and toss the metadata away with the underscore
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode(Result.self, from: data) {
                records = decodedResponse.records
                //print(records[0].images[0].imageid)
            }
            
        } catch {
            print("Invalid data")
        }
    }
}

/*
 struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/
