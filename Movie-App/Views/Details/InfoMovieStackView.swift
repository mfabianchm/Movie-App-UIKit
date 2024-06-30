//
//  InfoMovieStackView.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 20/06/24.
//

import UIKit

class InfoMovieStackView: UIStackView {
    
    let movieTitle = UILabel()
    
    let countryLabel = DetailsLabel(text: "Country: N/A")
    let releaseDateLabel = DetailsLabel(text: "")
    let languageLabel = DetailsLabel(text: "Original language: N/A")
    let statusLabel = DetailsLabel(text: "Status: N/A")
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
                
        self.translatesAutoresizingMaskIntoConstraints = false
        self.alignment = .leading
        self.spacing = 10
        self.axis = .vertical
        
        movieTitle.text = "N/A"
        movieTitle.font = UIFont(name: "Montserrat-SemiBold", size: 30)
        movieTitle.textColor = .white
       
        self.addArrangedSubview(movieTitle)
        self.addArrangedSubview(releaseDateLabel)
        self.addArrangedSubview(countryLabel)
        self.addArrangedSubview(languageLabel)
        self.addArrangedSubview(statusLabel)
    }
    
    func updateInfoStackView(title: String, language: String, country: [String], status: String, genres: [String], releaseDate: String) {
        if (!country.isEmpty) {
            countryLabel.text = "Country: \(country[0])"
        }
        movieTitle.text = title
        releaseDateLabel.text = "\(releaseDate)•\(genres.joined(separator: ", "))"
        languageLabel.text = "Original language: \(String(describing: language))"
        statusLabel.text = "Status: \(String(describing: status))"
    }
        
}
