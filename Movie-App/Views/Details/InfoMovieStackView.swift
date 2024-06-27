//
//  InfoMovieStackView.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 20/06/24.
//

import UIKit

class InfoMovieStackView: UIStackView {
    

    let title: String
    let releaseDate: String
    let language: String
    var country: [String]
    let status: String
    let genres: String
    
    let movieTitle = UILabel()
    
    var releaseDateLabel: DetailsLabel?
    var countryLabel: DetailsLabel?
    var languageLabel: DetailsLabel?
    var statusLabel:  DetailsLabel?
    
    init(title: String, releaseDate: String, language: String, country: [String], status: String, genres: String) {
        self.title = title
        self.releaseDate = releaseDate
        self.language = language
        self.country = country
        self.status = status
        self.genres = genres
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
        
        movieTitle.text = title
        movieTitle.font = UIFont(name: "Montserrat-SemiBold", size: 30)
        movieTitle.textColor = .white
        
        if (country.isEmpty) {
            countryLabel = DetailsLabel(text: "Country: N/A")
        } else {
            countryLabel = DetailsLabel(text: "Country: \(country[0])")
        }
       
        releaseDateLabel = DetailsLabel(text: "\(releaseDate)•\(genres)")
        languageLabel = DetailsLabel(text: "Original language: \(String(describing: language))")
        statusLabel = DetailsLabel(text: "Status: \(String(describing: status))")
        

        self.addArrangedSubview(movieTitle)
        self.addArrangedSubview(releaseDateLabel!)
        self.addArrangedSubview(countryLabel!)
        self.addArrangedSubview(languageLabel!)
        self.addArrangedSubview(statusLabel!)
        
    }
        
}
