//
//  MovieListApp.swift
//  MovieList
//
//  Created by Петя on 03.11.2026.
//

import SwiftUI
import SwiftData

@main
struct MovieListApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: [FavoriteMovie.self, RecentlyViewedMovie.self])
    }
}
