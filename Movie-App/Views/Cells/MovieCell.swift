//
//  MovieCell.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 06/06/24.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    let button = UIButton()
    let hdLabel = UILabel()
    
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
        addSubview(hdLabel)
        
//        button.setBackgroundImage(UIImage(named: "joker-image"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.contentVerticalAlignment = .bottom
        button.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 15.0, right: 10.0)
        button.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 23)
        button.titleLabel?.numberOfLines = 4
        button.tintColor = UIColor(named: "Medium-Gray")
        button.setBackgroundImage(UIImage(systemName: "square.fill"), for: .normal)
        button.isUserInteractionEnabled = false
        
        hdLabel.translatesAutoresizingMaskIntoConstraints = false
        hdLabel.text = "HD"
        hdLabel.backgroundColor = UIColor(named: "Yellow")
        hdLabel.layer.cornerRadius = 5
        hdLabel.layer.masksToBounds = true
        hdLabel.font = UIFont(name: "Montserrat-Medium", size: 10)
        hdLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.topAnchor.constraint(equalTo: topAnchor),
            
            hdLabel.topAnchor.constraint(equalTo: button.topAnchor, constant: 20),
            hdLabel.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -20),
            hdLabel.widthAnchor.constraint(equalToConstant: 25),
            hdLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configureData(model: Movie, posterImage: UIImage) {
        self.model = model
        button.setBackgroundImage(posterImage, for: .normal)
        button.setTitle(model.title, for: .normal)
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
