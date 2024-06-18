//
//  ProfileImageView.swift
//  Movie-App
//
//  Created by Marcos Chong on 18/06/24.
//

import UIKit

class ProfileImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.image = UIImage(named: "profile-image")
        self.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.clipsToBounds = true
    }
    
}
