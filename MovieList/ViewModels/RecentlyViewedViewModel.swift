//
//  RecentlyViewedViewModel.swift
//  MovieList
//
//  Created by Петя on 13.11.2026.
//

import Observation
import SwiftData
import Foundation
@Observable
class RecentlyViewedViewModel{
    let limitViewed = 5
    
    func addRecently(modelContext: ModelContext, recentlyViewed: RecentlyViewedMovie){
        
        do{
            
            
            let imdbID = recentlyViewed.imdbID
            let descriptor = FetchDescriptor<RecentlyViewedMovie>(
                predicate: #Predicate{$0.imdbID == imdbID}
            )
            let recentlyMovie = try modelContext.fetch(descriptor)
            
            
            let descriptorAll = FetchDescriptor<RecentlyViewedMovie>()
            let recentlyMoviesAll = try modelContext.fetch(descriptorAll)
            
            
            if(recentlyMovie.isEmpty && recentlyMoviesAll.count < limitViewed){
                modelContext.insert(recentlyViewed)
                try modelContext.save()
                print("Посещение сохранено")
            }else if (recentlyMoviesAll.count >= limitViewed){
                for movie in recentlyMoviesAll{
                    modelContext.delete(movie)
                }
                modelContext.insert(recentlyViewed)
                try modelContext.save()
                print("Посещения сброшены и последняя сохранена")
            }
        }catch{
            print(error)
            
        }
        
    }
}
