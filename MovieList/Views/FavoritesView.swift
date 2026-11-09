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
            ZStack{
                Color.black.opacity(0.75).ignoresSafeArea()
                List{
                    
                    ForEach(favorites){ movie in
                        HStack{
                            NavigationLink{
                                DetailView(movieOBJ: Movie(title: movie.title, year: movie.year, poster: URL(string: movie.poster)!, imdbID: movie.imdbID))
                            }label:{
                                AsyncImage(url: URL(string: movie.poster)){phase in
                                    if let image = phase.image{
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                    }
                                }
                            }
                            Text(movie.title)
                                .font(.headline)
                        }
                        .listRowBackground(Color.clear)
                        
                    }
                }
                .listRowSeparatorTint(.white)
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                .foregroundStyle(.white)
            }
            
        }
        
        
    }
}

#Preview {
    ContentView()
        .modelContainer(for: FavoriteMovie.self, inMemory: true)
    
//    FavoritesView(favorites: [FavoriteMovie(imdbID: "tt0816692", title: "Interstellar", year: "2014", poster: "https://m.media-amazon.com/images/M/MV5BYzdjMDAxZGItMjI2My00ODA1LTlkNzItOWFjMDU5ZDJlYWY3XkEyXkFqcGc@._V1_QL75_UX380_CR0,0,380,562_.jpg")])
        
        
    
    
}
