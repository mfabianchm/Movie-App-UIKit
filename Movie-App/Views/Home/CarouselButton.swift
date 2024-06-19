//
//  CarouselButton.swift
//  Movie-App
//
//  Created by Marcos Chong on 18/06/24.
//

import UIKit

class CarouselButton: UIButton {
    
    var title: String

    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(UIColor(named: "Yellow"), for: .selected)
    }

}
