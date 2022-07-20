//
//  HomeView.swift
//  ArtSeeker
//
//  Created by Andres Marquez on 2022-07-03.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = ResultViewModel(
        service: Network()
    )
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .success(let data):
                    ListView(data: data)
                        .searchable(text: $searchText, prompt: "Filter by a single keyword")
                        .onSubmit(of: .search) {
                            Task {
                                await viewModel.applySearchFilter(keyword: searchText)
                            }
                        }
                case .loading:
                    ProgressView()
                default:
                    Text("Something went wrong")
                }
            }
            .task {
                await viewModel.getResult()
            }
            .alert("Error", isPresented: $viewModel.hasError, presenting: viewModel.state) { detail in
                Button("Retry") {
                    Task {
                        await viewModel.getResult()
                    }
                }
            } message: { detail in
                if case let .failed(error) = detail {
                    Text(error.localizedDescription)
                }
            }
            .navigationTitle("Art Seeker")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button {
                            Task {
                                await viewModel.getPageNumber(pageNumberChange: -1)
                            }
                        } label: {
                            Image(systemName: "arrow.backward")
                        }
                        
                        Spacer()
                    
                        Button("Reset") {
                            searchText = ""
                            
                            Task {
                                await viewModel.applySearchFilter(keyword: "")
                            }
                        }
                        
                        Spacer()
                        
                        Button {
                            Task {
                                await viewModel.getPageNumber(pageNumberChange: +1)
                            }
                        } label: {
                            Image(systemName: "arrow.forward")
                        }
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

