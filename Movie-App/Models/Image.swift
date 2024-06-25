//
//  Image.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 24/06/24.
//

import Foundation


struct MovieImages: Decodable {
    var backdrops: [Image]
}


struct Image: Decodable {
    var filePath: String
}
