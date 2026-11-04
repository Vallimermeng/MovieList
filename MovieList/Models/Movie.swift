//
//  Movie.swift
//  MovieList
//
//  Created by Петя on 04.11.2026.
//

import Foundation

struct Movie: Codable{
    let title: String
    let year: String
    let poster: URL
    let imdbID: String
    
    
    enum CodingKeys: String, CodingKey{
        case title = "Title"
        case year = "Year"
        case poster = "Poster"
        case imdbID = "imdbID"
        
        
    }
}
