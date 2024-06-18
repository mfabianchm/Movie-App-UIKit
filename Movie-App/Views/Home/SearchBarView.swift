//
//  SearchBarView.swift
//  Movie-App
//
//  Created by Marcos Chong on 18/06/24.
//

import UIKit

class SearchBarView: UISearchBar {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.placeholder = "Search"
        self.barTintColor = UIColor(named: "Medium-Gray")
        self.searchTextField.backgroundColor = UIColor(named: "Medium-Gray")
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.searchTextField.leftView?.tintColor = UIColor(named: "Yellow")
    }

}
