//
//  CastCell.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 23/06/24.
//

import UIKit

class CastCell: UICollectionViewCell {
  
    let imageView = UIButton()
    let nameLabel = UILabel()
    let charactherLabel = UILabel()
    
    var image: UIImage?
    var actorName: String?
    var character: String?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func configure() {
        
        imageView.setBackgroundImage(UIImage(systemName: "person.fill"), for: .normal)
        imageView.layer.masksToBounds = true
        imageView.contentMode = .center
        imageView.layer.cornerRadius = 25
        imageView.translatesAutoresizingMaskIntoConstraints = false

        nameLabel.text = "N/A"
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont(name: "Montserrat-Semibold", size: 12)
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        charactherLabel.text = "N/A"
        charactherLabel.textAlignment = .center
        charactherLabel.font = UIFont(name: "Montserrat-Medium", size: 12)
        charactherLabel.textColor = .gray
        charactherLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(charactherLabel)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 50),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            charactherLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            charactherLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            charactherLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            
//            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    func configureData( image: UIImage, name: String, character: String) {
        self.image = image
        self.actorName = name
        self.character = character
        
        imageView.setBackgroundImage(image, for: .normal)
        nameLabel.text = name
        charactherLabel.text = character
    }
    
}
