//
//  AppLogoView.swift
//  Movie-App
//
//  Created by Marcos Chong on 18/06/24.
//

import UIKit

class AppLogoView: UIView {
    
    let logoImage = UIImageView()
    let appNameLabel = UILabel()
    
    var padding: CGFloat = 10.0

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        configureUIImageView()
        configureAppNameLabel()
        configureLayout()
    }
    
    func configureUIImageView() {
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.image = UIImage(systemName: "movieclapper")
        logoImage.tintColor = UIColor(named: "Yellow")
        self.addSubview(logoImage)
    }
    
    func configureAppNameLabel() {
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        appNameLabel.text = "Movie Online"
        appNameLabel.font = .systemFont(ofSize: 20)
        appNameLabel.textColor = .white
        self.addSubview(appNameLabel)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            logoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            logoImage.topAnchor.constraint(equalTo: self.topAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 50),
            logoImage.heightAnchor.constraint(equalToConstant: 50),
            
            appNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            appNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            appNameLabel.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: padding),
        ])
    }

}
