//
//  CustomBarButtonItem.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 23/05/24.
//

import UIKit

class CustomBarButtonItem: UIButton {
    
    var title: String
    var imageName: String

    init(title: String, imageName: String) {
        self.title = title
        self.imageName = imageName
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.backgroundColor = .blue
        self.setBackgroundImage(UIImage(systemName: imageName), for: .normal)
        self.setTitle(title, for: .normal)
        self.frame.size = CGSize(width: 70, height: 70)
    }

}
