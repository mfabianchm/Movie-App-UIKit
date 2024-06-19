//
//  Genre.swift
//  Movie-App
//
//  Created by Marcos Chong on 18/06/24.
//

import Foundation


struct Genres: Decodable {
    var genres: [Genre]
}

struct Genre: Decodable {
    var id: Int
    var name: String
}
