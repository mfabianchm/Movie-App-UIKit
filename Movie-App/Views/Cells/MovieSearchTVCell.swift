//
//  MovieSearchTVCell.swift
//  Movie-App
//
//  Created by Marcos Chong on 03/07/24.
//

import UIKit

class MovieSearchTVCell: UITableViewCell {
    
    var image: UIImage?
    var movieName: String?
    var releaseDate: String?
    
    let imageview = UIImageView()
    let titleLabel = UILabel()
    let releaseLabel = UILabel()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    func configure() {
        self.backgroundColor = UIColor(named: "Dark-Gray")
        self.addSubview(imageview)
        self.addSubview(titleLabel)
        self.addSubview(releaseLabel)
        
        configureImageView()
        configureTitleLabel()
        configureReleaseLabel()
        
        layout()
    }
    
    func configureImageView() {
        
        imageview.image = UIImage(systemName: "square.fill")
        imageview.contentMode = .scaleToFill
        imageview.tintColor = .gray
        imageview.layer.cornerRadius = 10
        imageview.layer.masksToBounds = true
        imageview.clipsToBounds = true
        imageview.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureTitleLabel() {
        titleLabel.text = "N/A"
        titleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 18)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureReleaseLabel() {
        releaseLabel.text = "N/A"
        releaseLabel.font = UIFont(name: "Montserrat-Medium", size: 16)
        releaseLabel.textColor = .gray
        releaseLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            imageview.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            imageview.heightAnchor.constraint(equalToConstant: 80),
            imageview.widthAnchor.constraint(equalToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: imageview.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: imageview.leadingAnchor, constant: -5),
            
            releaseLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            releaseLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ])
    }
    
    func configureData(title: String, releaseDate: String, posterImage: String?) {
        titleLabel.text = title
        releaseLabel.text = releaseDate
        
        Task {
            guard let posterImage = posterImage else {
                return
            }
            
            let image = await NetworkManager.shared.downloadImage(from: posterImage) ?? UIImage(systemName: "square.fill")
            imageview.image = image
        }
    }
    
    

}
