//
//  StoryLineView.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 24/06/24.
//

import UIKit

class StoryLineView: UIView {
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        
        titleLabel.text = "Storyline"
        titleLabel.font = UIFont(name: "Montserrat-Semibold", size: 16)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.text = "N/A"
        descriptionLabel.font = UIFont(name: "Montserrat-Medium", size: 16)
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 6
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
    
    func updateView(description: String) {
        descriptionLabel.text = description
    }

}
