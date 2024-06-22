//
//  InfoMovieStackView.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 20/06/24.
//

import UIKit

class InfoMovieStackView: UIStackView {
    
    var originalTitle: String?
    var releaseDate: String?
    var originalLanguage: String?
    var status: String?
    
    var countriesString: String?
    var genresString: String?
    
    
    let movieTitle = UILabel()
    
    var releaseDateLabel: DetailsLabel?
    var countryLabel: DetailsLabel?
    var languageLabel: DetailsLabel?
    var statusLabel:  DetailsLabel?
    
    init() {
        self.originalTitle = "N/A"
        self.releaseDate = "N/A"
        self.originalLanguage = "N/A"
        self.countriesString = "N/A"
        self.status = "N/A"
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
        
        movieTitle.text = originalTitle
        movieTitle.font = UIFont(name: "Montserrat-SemiBold", size: 30)
        movieTitle.textColor = .white
       
        releaseDateLabel = DetailsLabel(text: "\(releaseDate!)")
        countryLabel = DetailsLabel(text: "Country: \(countriesString!)")
        languageLabel = DetailsLabel(text: "Original language: \(String(describing: originalLanguage!))")
        statusLabel = DetailsLabel(text: "Status: \(String(describing: status!))")
        
        
        
        self.addArrangedSubview(movieTitle)
        self.addArrangedSubview(releaseDateLabel!)
        self.addArrangedSubview(countryLabel!)
        self.addArrangedSubview(languageLabel!)
        self.addArrangedSubview(statusLabel!)
        
    }
    
    
    func redrawView() {
        movieTitle.text = originalTitle
        releaseDateLabel?.text = "\(releaseDate!)"
        countryLabel!.text =  "Country: \(countriesString!)"
        languageLabel?.text =  "Original language: \(String(describing: originalLanguage!))"
        statusLabel?.text = "Status: \(String(describing: status!))"
    }
    
}
