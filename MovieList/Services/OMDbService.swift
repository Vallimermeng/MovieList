//
//  OMDbService.swift
//  MovieList
//
//  Created by Петя on 04.11.2026.
//

import Foundation

struct OMDbService{
    
    func getMovie(name: String) async throws -> [Movie]{
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.omdbapi.com"
        
        guard let apiKey = loadAPIKey() else {
            throw URLError(.userAuthenticationRequired)
        }
        components.queryItems = [
            URLQueryItem(name: "apikey", value: apiKey),
            URLQueryItem(name: "s", value: name)
        ]
        
        guard let url = components.url else{
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let respone = response as? HTTPURLResponse, (200...299).contains(respone.statusCode) else{
            throw URLError(.badServerResponse)
        }
        
        let movie = try JSONDecoder().decode(MovieSearch.self, from: data)
        
        return movie.search
    }
    
    func getMovieDetail(id: String) async throws -> MovieDetail {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.omdbapi.com"
        guard let apiKey = loadAPIKey() else {
            throw URLError(.userAuthenticationRequired)
        }
        components.queryItems = [
            URLQueryItem(name: "apikey", value: apiKey),
            URLQueryItem(name: "i", value: id)
        ]
        
        guard let url = components.url else{
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else{
            throw URLError(.badServerResponse)
        }
        let movie = try JSONDecoder().decode(MovieDetail.self, from: data)
        
        return movie
    }
    
    private func loadAPIKey() -> String?{
        guard
            let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist"),
            let data = try? Data(contentsOf: url),
            let plist = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String:String]
                else{
            return nil
        }
        
        return plist["OMDbAPIKey"]

                
    }
    
    
}
