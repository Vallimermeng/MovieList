//
//  MovieViewModel.swift
//  MovieList
//
//  Created by Петя on 04.11.2026.
//

import Foundation
import Observation

@Observable
class MovieViewModel{
    enum LoadingState{
        case loading
        case loaded
        case error(String)
    }
    let service = OMDbService()
    var state: LoadingState = .loading
    var movies: [Movie] = []
    var movieDetail: MovieDetail?
    
    func loadMovie(name: String)async{
        state = .loading
        do{
            let movie = try await service.getMovie(name: name)
            movies = movie
            state = .loaded
        }catch{
            state = .error("\(error)")
            print(error)
        }
        
    }
    
    func loadMovieDetail(id: String)async{
        state = .loading
        do{
            let movie = try await service.getMovieDetail(id: id)
            movieDetail = movie
            state = .loaded
        }catch{
            state = .error("\(error)")
            print(error)
        }
    }
    
}
