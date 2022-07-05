//
//  ContentView.swift
//  ArtSeeker
//
//  Created by Andres Marquez on 2022-06-28.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ResultViewModel(
        service: Network()
    )
    
    var body: some View {
        NavigationView {
            switch viewModel.state {
            case .success(let data):
                TabView {
                    HomeView(data: data)
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                    ExploreView()
                        .tabItem {
                            Label("Explore", systemImage: "magnifyingglass")
                        }
                    SettingsView()
                        .tabItem {
                            Label("Settings", systemImage: "gear")
                        }
                }
            case .loading:
                ProgressView()
                
            default:
                Text("")
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
    }
}

 struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
