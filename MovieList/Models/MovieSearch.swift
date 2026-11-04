//
//  MovieSearch.swift
//  MovieList
//
//  Created by Петя on 04.11.2026.
//

import Foundation

struct MovieSearch: Codable{
    let search: [Movie]
    
    enum CodingKeys: String, CodingKey{
        case search = "Search"
    }
}
