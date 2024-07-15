//
//  FavoriteImageView.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 10/07/24.
//

import UIKit

class FavoriteImageView: UIImageView {
    
//    let cache               = NetworkManager.shared.cache
    let placeholderImage = UIImage(systemName: "person.fill")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func downloadImage(fromURL url: String) {
        Task { image = await NetworkManager.shared.downloadImage(from: url) ?? placeholderImage }
    }
    

}
