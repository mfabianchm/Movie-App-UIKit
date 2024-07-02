//
//  SocialMediaButtons.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 30/06/24.
//

import UIKit

enum Images {
    static let facebook = UIImage(named: "facebook-logo")
    static let instagram = UIImage(named: "instagram-logo")
    static let linkedin = UIImage(named: "linkedin-logo")
    static let pinterest = UIImage(named: "pinterest-logo")
    static let telegram = UIImage(named: "telegram-logo")
}

class SocialMediaButtons: UIView {
    
    let stackView = UIStackView(frame: .zero)
    let titleLabel = UILabel()
    let images = [Images.facebook, Images.instagram, Images.linkedin, Images.pinterest, Images.telegram]

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "Share in"
        titleLabel.font = UIFont(name: "Montserrat-Semibold", size: 16)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.addSubview(titleLabel)
        self.addSubview(stackView)
        
        configureStackView()
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            stackView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor,constant: 20),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
        
    }
    
    func configureStackView() {
        images.forEach { image in
            let imageView: UIImageView = {
                let imageView = UIImageView()
                imageView.image = image
                imageView.layer.cornerRadius = 20
                imageView.layer.masksToBounds = true
                imageView.contentMode = .scaleAspectFit
                return imageView
            }()
            
            NSLayoutConstraint.activate([
                imageView.heightAnchor.constraint(equalToConstant: 40),
                imageView.widthAnchor.constraint(equalToConstant: 40)
            ])
            
            stackView.addArrangedSubview(imageView)
            
        }
    }

}
