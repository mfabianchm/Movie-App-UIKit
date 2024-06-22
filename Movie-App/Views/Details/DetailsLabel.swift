//
//  DetailsLabel.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 20/06/24.
//

import UIKit

class DetailsLabel: UILabel {

    var titleToDisplay: String?
    
    init(text: String) {
        self.titleToDisplay = text
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.text = titleToDisplay
        self.font = UIFont(name: "Montserrat-SemiBold", size: 13)
        self.textColor = .gray
    }

}
