//
//  IconsStackView.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 20/06/24.
//

import UIKit

class IconsStackView: UIStackView {
    
    let iconsName: [String] = ["heart","square.and.arrow.up" ,"bookmark"]

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        iconsName.forEach { icon in
            let button: UIButton = {
                let button = UIButton(type: .system)
                button.setImage(UIImage(systemName: icon), for: .normal)
                button.tintColor = .white
                return button
            }()
            
            self.addArrangedSubview(button)
        }
        
        self.axis = .horizontal
        self.spacing = 5
        self.alignment = .center
        self.distribution = .fillProportionally
        self.translatesAutoresizingMaskIntoConstraints = false
    }

}
