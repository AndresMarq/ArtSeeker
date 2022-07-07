//
//  HomeView.swift
//  ArtSeeker
//
//  Created by Andres Marquez on 2022-07-03.
//

import SwiftUI

struct HomeView: View {
    let data: [Result.Record]
    @EnvironmentObject var viewModel: ResultViewModel
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                List(data, id: \.id) { record in
                    HStack {
                        ImageView(
                            imageURL: record.images?.first?.baseimageurl,
                            imageAspectRatioInt: (record.images?.first?.width ?? 1) / (record.images?.first?.height ?? 1)
                        )
                            .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.3)
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
            .navigationTitle("Art Seeker")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button {
                    Task {
                        await viewModel.getPageNumber(pageNumberChange: -1)
                    }
                } label: {
                    Image(systemName: "arrow.backward")
                },
                trailing: Button {
                    Task {
                        await viewModel.getPageNumber(pageNumberChange: +1)
                    }
                } label: {
                    Image(systemName: "arrow.forward")
                }
            )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(data: ResultExample.records)
    }
}

