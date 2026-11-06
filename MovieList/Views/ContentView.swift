//
//  ContentView.swift
//  MovieList
//
//  Created by Петя on 03.11.2026.
//

import SwiftUI

struct ContentView: View {
    
    @State private var movieViewModel = MovieViewModel()
    @State private var nameField: String = ""
    @State private var isPressed: Bool = false
    
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
                    
                    
                    
                }
                .padding()
                
            }
        }
        .foregroundStyle(.white)
        
        
        

        
        
    }
}

#Preview {
    ContentView()
        
    
}
