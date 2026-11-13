//
//  ContentView.swift
//  MovieList
//
//  Created by Петя on 03.11.2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State private var movieViewModel = MovieViewModel()
    @State private var nameField: String = ""
    @State private var isPressed: Bool = false
    
    @Query private var recentlyViewedMovie: [RecentlyViewedMovie]
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                Color.black.opacity(0.8).ignoresSafeArea()
                VStack {
                    
                    TextField(
                        "Введите название фильма",
                        text: $nameField
                    )
                    .keyboardType(.asciiCapable)
                    .foregroundStyle(.white)
                    .background(.white)
                    Button("Найти"){
                        Task{
                            await movieViewModel.loadMovie(name: nameField)
                        }
                        isPressed = true // no toggle
                    }
                    
                    
                    if(isPressed){
                        
                        
                        switch movieViewModel.state{
                        case .loading:
                            ProgressView("Загрузка")
                                .progressViewStyle(.circular)
                            
                        case .loaded:
                            ScrollView{
                                VStack{
                                    ForEach(movieViewModel.movies, id:\.imdbID){movie in
                                        Text(movie.title)
                                        NavigationLink{
                                            DetailView(movieOBJ: movie)
                                        }label:{
                                            AsyncImage(url: movie.poster){phase in
                                                if let image = phase.image{
                                                    image
                                                        .resizable()
                                                        .scaledToFit()
                                                }
                                                
                                            }
                                        }
                                    }
                                }
                            }
                            
                        case .error(let error):
                            Text("Произошла ошибка: \(error)")
                            
                        }
                    }
                    Divider()
                        .background(.black)
                    Text("Последние просмотры")
                        .font(.title)
                        .font(.headline)
                    HStack{
                        
                        ForEach(recentlyViewedMovie, id: \.imdbID){recentlyMovie in
                            AsyncImage(url: URL(string: recentlyMovie.poster)!){phase in
                                if let image = phase.image{
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                }
                                
                                
                            }
                            Text(recentlyMovie.title)
                            
                        }
                        
                    }
                    Divider()
                        .background(.black)
                    
                    
                    
                }
                .padding()
                
            }
        }
        .foregroundStyle(.white)
        
        
        

        
        
    }
}

#Preview {
    HomeView()
        .modelContainer(for: FavoriteMovie.self, inMemory: true)
        
        
    
}
