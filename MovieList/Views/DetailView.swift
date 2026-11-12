//
//  DetailView.swift
//  MovieList
//
//  Created by Петя on 04.11.2026.
//

import SwiftUI
import SwiftData

struct DetailView: View{
    let movieOBJ: Movie
    @State private var movieViewModel = MovieViewModel()
    
    @Environment(\.modelContext)
    private var modelContext
    @Query private var isHasMovie: [FavoriteMovie]
    
    init(movieOBJ: Movie){
        self.movieOBJ = movieOBJ
        
        _isHasMovie = Query(filter: #Predicate { $0.imdbID == movieOBJ.imdbID
        })
        
    }
    
    var body: some View{
        ZStack{
            Color.black.opacity(0.75).ignoresSafeArea()
            ScrollView{
                
                VStack(spacing:16){
                    
                    switch movieViewModel.state{
                    case .loading:
                        ProgressView()
                            .progressViewStyle(.circular)
                        
                    case .loaded:
                        
                        
                        if let movie = movieViewModel.movieDetail{
                            AsyncImage(url: movie.poster){phase in
                                if let image = phase.image{
                                    ZStack{
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                            .overlay(
                                                LinearGradient(colors: [.clear, .black.opacity(0.9)], startPoint: .top, endPoint: .bottom)
                                            )
                                            .frame(height: .infinity)
                                        
                                        VStack{
                                            Spacer()
                                            Text(movie.title)
                                                .font(.title)
                                                .fontWeight(.semibold)
                                                .foregroundStyle(.white)
                                        }
                                    }
                                    
                                    
                                    
                                }
                            }
                            
                            HStack(spacing: 16){
                                
                                Text("\(Image(systemName: "star")) \(movie.imdbRating)")
                                Text("\(Image(systemName: "clock")) \(movie.runtime)")
                                Text("\(Image(systemName: "calendar")) \(movie.released)")
                                
                                if(isHasMovie.isEmpty){
                                    Button("Добавить в избранное"){
                                        do{
                                            let favorite = FavoriteMovie(imdbID: movie.imdbID, title: movie.title, year: movie.year, poster: movie.poster.absoluteString)
                                            modelContext.insert(favorite)
                                            try modelContext.save()
                                            print("Фильм успешно добавлен в избранное!")
                                            
                                        }catch{
                                            print("Ошибка при работе с базой данных: \(error.localizedDescription)")
                                        }
                                    }
                                }else{
                                    Button("Удалить из избранного"){
                                        
                                        if let movie = isHasMovie.first{
                                            modelContext.delete(movie)
                                        }
                                        print("Удален из избранного")
                                    }
                                }
                            }
                            
                            Divider()
                                .background(.white)
                            
                            Text("Overview")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title)
                                .fontWeight(.semibold)
                            Text(movie.plot)
                            
                            Divider()
                                .background(.white)
                            
                            Text("Details")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title)
                                .fontWeight(.semibold)
                            HStack(spacing: 20){
                                Text("Director: \(movie.writer)")
                                Text("Country: \(movie.country)")
                                Text("Genre: \(movie.genre)")
                            }
                        }
                        
                    case .error(let error):
                        Text("Произошла ошибка: \(error)")
                        
                    }
                }
                
            
            }
        }
        .onAppear(){
            
            Task{
                await movieViewModel.loadMovieDetail(id: movieOBJ.imdbID)
                
            }
        }
        .foregroundStyle(.white)
        .font(.headline)
    }

}



#Preview {
    DetailView(movieOBJ: Movie(
        title: "Interstellar",
        year: "2014",
        poster: URL(string: "https://m.media-amazon.com/images/M/MV5BYzdjMDAxZGItMjI2My00ODA1LTlkNzItOWFjMDU5ZDJlYWY3XkEyXkFqcGc@._V1_QL75_UX380_CR0,0,380,562_.jpg")!,
        imdbID: "tt0816692"
    ))
    .modelContainer(for: FavoriteMovie.self, inMemory: true)
}
