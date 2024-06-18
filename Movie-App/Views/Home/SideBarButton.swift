//
//  SideBarButton.swift
//  Movie-App
//
//  Created by Marcos Chong on 18/06/24.
//

import UIKit

class SideBarButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setImage(UIImage(systemName: "list.dash"), for: .normal)
        self.tintColor = .white
        self.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.clipsToBounds = true
        self.layer.borderColor = UIColor(named: "Medium-Gray")?.cgColor
        self.layer.borderWidth = 1
    }

}
