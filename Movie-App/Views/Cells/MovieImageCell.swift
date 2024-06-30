//
//  MovieImageCell.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 24/06/24.
//

import UIKit

class MovieImageCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func configure() {
        self.backgroundColor = .red
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        imageView.image = UIImage(systemName: "square.fill")
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
    }
    
    func configureData( image: UIImage) {
        imageView.image = image
    }
}
