//
//  RecommendedMoviesCell.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 01/07/24.
//

import UIKit

class RecommendedMoviesCell: UICollectionViewCell {
    let button = UIButton()
    let nameLabel = UILabel()
    
    var model: Movie?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func configure() {
        self.layer.cornerRadius = 15

        addSubview(button)
        addSubview(nameLabel)
        
        button.setBackgroundImage(UIImage(systemName: "square.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = false
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "N/A"
        nameLabel.font = UIFont(name: "Montserrat-Medium", size: 16)
        nameLabel.textAlignment = .center
        nameLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.topAnchor.constraint(equalTo: topAnchor),
            button.heightAnchor.constraint(equalToConstant: 290),
            
            nameLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: button.trailingAnchor),
        ])
    }
    
    func configureData(title: String, posterImage: String) {
        
        Task {
            let image = await NetworkManager.shared.downloadImage(from: posterImage) ?? UIImage(systemName: "square.fill")
            button.setBackgroundImage(image, for: .normal)
            nameLabel.text = title
        }

    }
    
    func transformToLarge(){
        UIView.animate(withDuration: 0.2){
          self.transform = CGAffineTransform(scaleX: 1.07, y: 1.07)
        }
      }
      
    func transformToStandard(){
        UIView.animate(withDuration: 0.2){
            self.transform = CGAffineTransform.identity
        }
    }
}
