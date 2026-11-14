//
//  FavoritesViewModel.swift
//  MovieList
//
//  Created by Петя on 14.11.2026.
//

import Foundation
import SwiftData
import Observation

@Observable
class FavoritesViewModel{
    
    func addFavorite(favorite: FavoriteMovie, modelContext: ModelContext){
        
        do{
            modelContext.insert(favorite)
            try modelContext.save()
            
        }catch{
            print("Ошибка при работе с базой данных: \(error.localizedDescription)")
        }
        
        
    }
    
    func deleteFavorite(movie: Movie, modelContext: ModelContext){
        do{
            let imdbID = movie.imdbID
            let descriptor = FetchDescriptor<FavoriteMovie>(
                predicate: #Predicate{$0.imdbID == imdbID}
            )
            let favoritesAll = try modelContext.fetch(descriptor)
            if let favorites = favoritesAll.first{
                modelContext.delete(favorites)
                try modelContext.save()
            }
            
        }catch{
            print(error)
        }
        
    }
    
    
}
