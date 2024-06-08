//
//  MovieCell.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 06/06/24.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func configure() {
        self.layer.cornerRadius = 15
        
        addSubview(button)
        button.setBackgroundImage(UIImage(named: "joker-image"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.topAnchor.constraint(equalTo: topAnchor),
        ])
    }
    
    func configureData(model: MovieTest) {
        button.setBackgroundImage(UIImage(named: model.imageMovie), for: .normal)
    }
}
