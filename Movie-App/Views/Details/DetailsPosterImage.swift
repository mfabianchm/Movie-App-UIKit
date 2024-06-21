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
    
    var posterImage: UIImage?
    var movieGenres: [String]?
    
    init() {
        super.init(frame: .zero)
        configure()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        self.image = self.posterImage
        self.contentMode = .scaleToFill
        self.backgroundColor = .gray
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(hdLabel)
        self.addSubview(qualityLabel)
        
        hdLabel.translatesAutoresizingMaskIntoConstraints = false
        hdLabel.text = "HD"
        hdLabel.backgroundColor = UIColor(named: "Yellow")
        hdLabel.layer.cornerRadius = 5
        hdLabel.layer.masksToBounds = true
        hdLabel.font = UIFont(name: "Montserrat-Medium", size: 15)
        hdLabel.textAlignment = .center
        
        qualityLabel.translatesAutoresizingMaskIntoConstraints = false
        qualityLabel.text = "4K"
        qualityLabel.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        qualityLabel.textColor = .white
        qualityLabel.layer.cornerRadius = 5
        qualityLabel.layer.masksToBounds = true
        qualityLabel.font = UIFont(name: "Montserrat-Medium", size: 15)
        qualityLabel.textAlignment = .center
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
        ])
       
    }

}
