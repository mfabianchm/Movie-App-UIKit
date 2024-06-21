//
//  DetailsContentView.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 20/06/24.
//

import UIKit

class DetailsContentView: UIView {
    
    let profileImage = ProfileImageView(frame: .zero)
    let mainMovieImage = DetailsPosterImage()
    
    var padding: CGFloat = 10
    
    let hdLabel = UILabel()
    let qualityLabel = UILabel()
    let genresStackView = UIStackView()
    let rankingLabel = UILabel()
    let iconsStack = UIStackView()
    let infoMovieStack = UIStackView()
    
    var posterImage: UIImage?
    var movieGenres: [String] = []
    var model: Movie?

     init(model: Movie, genres: [String]) {
         self.model = model
         self.movieGenres = genres
         super.init(frame: .zero)
         configure()
         addViews()
         configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(named: "Dark-Gray")
        profileImage.layer.zPosition = 100
    }
    
    func addViews() {
        self.addSubview(profileImage)
        self.addSubview(mainMovieImage)
    }
    
    func configureLayout() {
        
        NSLayoutConstraint.activate([
            profileImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: -45),
            profileImage.widthAnchor.constraint(equalToConstant: 50),
            profileImage.heightAnchor.constraint(equalToConstant: 50),
            
            mainMovieImage.topAnchor.constraint(equalTo: self.topAnchor),
            mainMovieImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainMovieImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainMovieImage.heightAnchor.constraint(equalToConstant: 550),
        ])
        
    }

}

