//
//  FavoriteMovie.swift
//  MovieList
//
//  Created by Петя on 07.11.2026.
//
import Foundation
import SwiftData

@Model
class FavoriteMovie{
    @Attribute(.unique) var imdbID: String
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
