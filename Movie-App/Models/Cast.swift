//
//  Cast.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 23/06/24.
//

import UIKit

struct Cast: Decodable {
    var cast: [Person]
}

struct Person: Decodable {
    var name: String
    var character: String
    var profilePath: String?
}

struct Character {
    var name: String
    var character: String
    var image: UIImage
}
