//
//  ButtonsStackView.swift
//  Movie-App
//
//  Created by Marcos Chong on 18/06/24.
//

import UIKit

class ButtonsStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .horizontal
        self.distribution = .equalSpacing
    }

}
