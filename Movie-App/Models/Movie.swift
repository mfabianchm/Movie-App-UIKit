//
//  Movie.swift
//  Movie-App
//
//  Created by Marcos Chong on 18/06/24.
//

import UIKit



struct Movie: Decodable {
    var genreIds: [Int]
    var id: Int
    var originalLanguage: String
    var originalTitle: String
    var popularity: Float
    var posterPath: String?
    var releaseDate: String
    var title: String
    var video: Bool
    var voteAverage: Float
    var voteCount: Int
    var overview: String?
}

struct Movies: Decodable {
    var results: [Movie]
}

struct MoviesData {
    var data: [Movie]
    var posterImages: [UIImage]
}

struct MovieDetails: Decodable {
    var originCountry: [String]
    var originalLanguage: String
    var releaseDate: String
    var status: String
}
