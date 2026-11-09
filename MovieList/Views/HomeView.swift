//
//  HomeView.swift
//  MovieList
//
//  Created by Петя on 09.11.2026.
//

import SwiftUI
import SwiftData

struct HomeView: View{
    
    var body: some View{
        TabView{
            ContentView()
                .tabItem{
                    Label("Поиск", systemImage: "magnifyingglass")
                }
            
            FavoritesView()
                .tabItem{
                    Label("Избранное", systemImage: "star")
                }
            
        }
    }
}

#Preview {
    HomeView()
}
