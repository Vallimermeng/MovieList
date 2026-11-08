//
//  FavoritesView.swift
//  MovieList
//
//  Created by Петя on 09.11.2026.
//

import SwiftUI
import SwiftData

struct FavoritesView: View{
    @Query private var favorites: [FavoriteMovie]
    
    var body: some View{
        NavigationStack{
            List{
                ForEach(favorites){ movie in
                    Text(movie.title)
                    
                }
            }
            .foregroundStyle(.black)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: FavoriteMovie.self, inMemory: true)
        
        
    
}
