//
//  DetailsPosterImage.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 20/06/24.
//

import UIKit

class DetailsPosterImage: UIImageView {

    let hdLabel = UILabel()
    let qualityLabel = UILabel()
    let genresStackView = UIStackView()
    
    var movieGenres: [String]?
    
    init(movieGenres: [String]) {
        self.movieGenres = movieGenres
        super.init(frame: .zero)
        configure()
        setGenresStackView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        self.image = UIImage(systemName: "square.fill" )
        self.contentMode = .scaleAspectFill
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(hdLabel)
        self.addSubview(qualityLabel)
        
        configureHDLabel()
        configureQualityLabel()
        configureGenresStackView()
    }
    
    func configureHDLabel() {
        hdLabel.translatesAutoresizingMaskIntoConstraints = false
        hdLabel.text = "HD"
        hdLabel.backgroundColor = UIColor(named: "Yellow")
        hdLabel.layer.cornerRadius = 5
        hdLabel.layer.masksToBounds = true
        hdLabel.font = UIFont(name: "Montserrat-Medium", size: 15)
        hdLabel.textAlignment = .center
    }
    
    func configureQualityLabel() {
        qualityLabel.translatesAutoresizingMaskIntoConstraints = false
        qualityLabel.text = "4K"
        qualityLabel.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        qualityLabel.textColor = .white
        qualityLabel.layer.cornerRadius = 5
        qualityLabel.layer.masksToBounds = true
        qualityLabel.font = UIFont(name: "Montserrat-Medium", size: 15)
        qualityLabel.textAlignment = .center
    }
    
    func configureGenresStackView() {
        genresStackView.axis = .horizontal
        genresStackView.spacing = 5
        genresStackView.alignment = .fill
        genresStackView.distribution = .fillProportionally
        genresStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(genresStackView)
    }
    
    func setGenresStackView() {
        movieGenres!.forEach { genre in
            let genreLabel: UILabel = {
                let label = UILabel()
                label.backgroundColor = UIColor.black.withAlphaComponent(0.3)
                label.font = UIFont(name: "Montserrat-Medium", size: 13)
                label.textColor = .white
                label.layer.cornerRadius = 5
                label.layer.masksToBounds = true
                label.textAlignment = .center
                return label
            }()
            
            genreLabel.text = genre
            genresStackView.addArrangedSubview(genreLabel)
        }
        
    }
    
    func configureLayout() {
        
        NSLayoutConstraint.activate([
            hdLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            hdLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            hdLabel.widthAnchor.constraint(equalToConstant: 30),
            hdLabel.heightAnchor.constraint(equalToConstant: 25),
            
            qualityLabel.bottomAnchor.constraint(equalTo: hdLabel.bottomAnchor),
            qualityLabel.leadingAnchor.constraint(equalTo: hdLabel.trailingAnchor, constant: 5),
            qualityLabel.widthAnchor.constraint(equalToConstant: 30),
            qualityLabel.heightAnchor.constraint(equalToConstant: 25),
            
            genresStackView.bottomAnchor.constraint(equalTo: hdLabel.bottomAnchor),
            genresStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            genresStackView.heightAnchor.constraint(equalToConstant: 25),
        ])
       
    }
    
    func updateImageView(image: UIImage) {
        self.image = image
    }

}
