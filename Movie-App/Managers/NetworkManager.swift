//
//  NetworkManager.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 22/05/24.
//

import UIKit

enum MovieAppError: String, Error {
    case invalidURL = "Invalid URL!"
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


class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://api.themoviedb.org/3/"
    let decoder = JSONDecoder()
    
    func getMovies(requestName: EndPoint) async throws -> MoviesData {
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
            throw MovieAppError.invalidURL
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjNjI5MzYzYmNlMmEyNDQ0Yzc3NmU5ZGI3NDlkMjg2MiIsInN1YiI6IjY1Mjc1OWQ2ODEzODMxMDBlMTJlMGZlYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eIYhB8d7dfMO53g5e_y7Vqu0O08NINMKdoY1NZrO-FU"
        ]
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw MovieAppError.invalidResponse
        }
        
        do {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let movies = try decoder.decode(Movies.self, from: data)
            var moviesCoverImages: [UIImage] = []
            
            movies.results.forEach { movie in
                guard let posterPath = movie.posterPath else {return}
                let url = URL(string: "https://image.tmdb.org/t/p/original\(posterPath)")
                let data = try? Data(contentsOf: url!)
                
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    moviesCoverImages.append(image!)
                }
            }
            
            let moviesData = MoviesData(data: movies.results, posterImages: moviesCoverImages)
            return moviesData
            
        } catch  {
            throw MovieAppError.errorInParsing
        }
        
    }
    
    
    func searchMovie(movieName: String) async throws -> Movies? {
        let endPoint = baseURL + "search/movie"
           
        guard let url = URL(string: endPoint) else {
            throw MovieAppError.invalidURL
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "query", value: movieName),
          URLQueryItem(name: "language", value: "en-US"),
          URLQueryItem(name: "page", value: "1"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjNjI5MzYzYmNlMmEyNDQ0Yzc3NmU5ZGI3NDlkMjg2MiIsInN1YiI6IjY1Mjc1OWQ2ODEzODMxMDBlMTJlMGZlYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eIYhB8d7dfMO53g5e_y7Vqu0O08NINMKdoY1NZrO-FU"
        ]
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw MovieAppError.invalidResponse
        }
        
        do {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let movies = try decoder.decode(Movies.self, from: data)
            return movies
        } catch  {
            throw MovieAppError.errorInParsing
        }
    }
        
    
    func getMovieDetails(id: Int) async throws -> MovieDetails? {
        let endPoint = baseURL + "movie/\(id.description)"
        
        guard let url = URL(string: endPoint) else {
            throw MovieAppError.invalidURL
        }
        
        let urlRequest = createURLRequest(url: url, hasQuerys: true)
            
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw MovieAppError.invalidResponse
        }
        
        do {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let movieDetails = try decoder.decode(MovieDetails.self, from: data)
            return movieDetails
        } catch  {
            throw MovieAppError.errorInParsing
        }
    }
    
    
    
    
    func getMovieGenres() async throws -> Genres? {
        let endPoint = baseURL + "genre/movie/list"
        
        guard let url = URL(string: endPoint) else {
            throw MovieAppError.invalidURL
        }
        
        let urlRequest = createURLRequest(url: url, hasQuerys: true)
            
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw MovieAppError.invalidResponse
        }
        
        do {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let genres = try decoder.decode(Genres.self, from: data)
            return genres
        } catch  {
            throw MovieAppError.errorInParsing
        }
        
    }
    
    func getCastInfo(id: Int) async throws -> Cast? {
        let endPoint = baseURL + "movie/\(id)/credits"
        
        guard let url = URL(string: endPoint) else {
            throw MovieAppError.invalidURL
        }
        
        let urlRequest = createURLRequest(url: url, hasQuerys: true)
            
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw MovieAppError.invalidResponse
        }
        
        do {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let cast = try decoder.decode(Cast.self, from: data)
            return cast
        } catch  {
            throw MovieAppError.errorInParsing
        }
    }
    
    
    func getMovieImages(id: Int) async throws -> [UIImage]? {
        let endPoint = baseURL + "movie/\(id)/images"
       
        guard let url = URL(string: endPoint) else {
            throw MovieAppError.invalidURL
        }
        
        let urlRequest = createURLRequest(url: url, hasQuerys: false)
            
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw MovieAppError.invalidResponse
        }
        
        do {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let imagesPath = try decoder.decode(MovieImages.self, from: data)
            var movieImages: [UIImage] = []
            
            imagesPath.backdrops.forEach { image in
                let url = URL(string: "https://image.tmdb.org/t/p/original\(image.filePath)")
                let data = try? Data(contentsOf: url!)
                
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    movieImages.append(image!)
                } 
            }
            
            return movieImages
            
        } catch  {
            throw MovieAppError.errorInParsing
        }
    }
    
    
    func createURLRequest(url: URL, hasQuerys: Bool) -> URLRequest {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        if(hasQuerys) {
            let queryItems: [URLQueryItem] = [
                URLQueryItem(name: "language", value: "en-US"),
            ]
            components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjNjI5MzYzYmNlMmEyNDQ0Yzc3NmU5ZGI3NDlkMjg2MiIsInN1YiI6IjY1Mjc1OWQ2ODEzODMxMDBlMTJlMGZlYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eIYhB8d7dfMO53g5e_y7Vqu0O08NINMKdoY1NZrO-FU"
        ]
        
        return request
    }
    
        
//    func getImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
//        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
//    }
    
}


