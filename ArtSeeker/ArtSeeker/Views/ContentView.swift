//
//  ContentView.swift
//  ArtSeeker
//
//  Created by Andres Marquez on 2022-06-28.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            HomeView()
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
    }
}

 struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
