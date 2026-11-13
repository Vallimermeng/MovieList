//
//  RecentlyViewedMovie.swift
//  MovieList
//
//  Created by Петя on 13.11.2026.
//

import SwiftData

@Model
class RecentlyViewedMovie{
    var imdbID: String
    var title: String
    var year: String
    var poster: String
    
    init(imdbID: String, title: String, year: String, poster: String) {
        self.imdbID = imdbID
        self.title = title
        self.year = year
        self.poster = poster
    }
    
    
    
    
}
