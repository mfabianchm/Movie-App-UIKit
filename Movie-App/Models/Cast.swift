//
//  Cast.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 23/06/24.
//

import Foundation

struct Cast: Decodable {
    var cast: [Person]
}

struct Person: Decodable {
    var name: String
    var character: String
}
