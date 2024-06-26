//
//  NetworkManager.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 22/05/24.
//

import UIKit

enum MovieAppError: String, Error {
    case invalidUsername = "Invalid URL!"
    case invalidResponse = "Invalid Response"
    case unableToComplete = "Unable to complete"
    case invalidData = "Invalid Data"
    case errorInParsing = "Error at parsing data"
}

enum EndPoint: String {
    case moviesInTheatres = "movie/now_playing"
    case popularMovies = "movie/popular"
    case ratedMovies = "movie/top_rated"
    case upcomingMovies = "movie/upcoming"
}

struct Movie: Decodable {
    var id: Int
    var originalLanguage: String
    var originalTitle: String
    var popularity: Float
    var overview: String
    var posterPath: String?
    var releaseDate: String
    var title: String
    var video: Bool
    var voteAverage: Float
    var voteCount: Int
}

struct Movies: Decodable {
    var results: [Movie]
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://api.themoviedb.org/3/"
    let decoder = JSONDecoder()
    
    func getMovies(requestName: EndPoint, completed: @escaping (Result<Movies, MovieAppError>) -> Void) {
        
        let endPoint: String
        
        switch requestName {
        case .popularMovies:
            endPoint = baseURL + requestName.rawValue
        case .moviesInTheatres:
            endPoint = baseURL + requestName.rawValue
        case .ratedMovies:
            endPoint = baseURL + requestName.rawValue
        case .upcomingMovies:
            endPoint = baseURL + requestName.rawValue
        }
            
           
        guard let url = URL(string: endPoint) else {
            print("invalid URL")
            return
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        print(components.url!)
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjNjI5MzYzYmNlMmEyNDQ0Yzc3NmU5ZGI3NDlkMjg2MiIsInN1YiI6IjY1Mjc1OWQ2ODEzODMxMDBlMTJlMGZlYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eIYhB8d7dfMO53g5e_y7Vqu0O08NINMKdoY1NZrO-FU"
        ]

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movies = try decoder.decode(Movies.self, from: data)
                completed(.success(movies))
            } catch {
                completed(.failure(.errorInParsing))
            }
        }
        
        task.resume()
        }
    
    
    
    func searchMovie(movieName: String, completed: @escaping (Result<Movies, MovieAppError>) -> Void) {
        
        let endPoint = baseURL + "search/movie"
           
        guard let url = URL(string: endPoint) else {
            print("invalid URL")
            return
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "query", value: movieName),
          URLQueryItem(name: "language", value: "en-US"),
          URLQueryItem(name: "page", value: "1"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        print(components.url!)
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjNjI5MzYzYmNlMmEyNDQ0Yzc3NmU5ZGI3NDlkMjg2MiIsInN1YiI6IjY1Mjc1OWQ2ODEzODMxMDBlMTJlMGZlYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eIYhB8d7dfMO53g5e_y7Vqu0O08NINMKdoY1NZrO-FU"
        ]

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                print(data)
                let movies = try decoder.decode(Movies.self, from: data)
                completed(.success(movies))
            } catch {
                completed(.failure(.errorInParsing))
            }
        }
        
        task.resume()
        }
    
    
    
    
}


