//
//  DetailView.swift
//  MovieList
//
//  Created by Петя on 04.11.2026.
//

import SwiftUI

struct DetailView: View{
    let movieOBJ: Movie
    @State private var movieViewModel = MovieViewModel()
    
    var body: some View{
        ScrollView{
            VStack{
                switch movieViewModel.state{
                case .loading:
                    ProgressView()
                        .progressViewStyle(.circular)
                    
                case .loaded:
                    if let movie = movieViewModel.movieDetail{
                        AsyncImage(url: movie.poster){phase in
                            if let image = phase.image{
                                image
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                        Text(movie.title)
                            .font(.headline)
                    }
                    
                    
                case .error(let error):
                    Text("Произошла ошибка: \(error)")

                }
            }
        }
        .onAppear(){
            
            Task{
                await movieViewModel.loadMovieDetail(id: movieOBJ.imdbID)
                
            }
        }
    }

}

#Preview {
    DetailView(movieOBJ: Movie(
        title: "Interstellar",
        year: "2014",
        poster: URL(string: "https://m.media-amazon.com/images/M/MV5BYzdjMDAxZGItMjI2My00ODA1LTlkNzItOWFjMDU5ZDJlYWY3XkEyXkFqcGc@._V1_QL75_UX380_CR0,0,380,562_.jpg")!,
        imdbID: "tt0816692"
    ))
}
