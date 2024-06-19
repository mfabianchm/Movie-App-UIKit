//
//  LoadingView.swift
//  Movie-App
//
//  Created by Marcos Chong on 11/06/24.
//

import UIKit

class LoadingView: UIActivityIndicatorView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        color = .white
        layer.cornerRadius = 3.0
        clipsToBounds = true
        hidesWhenStopped = true
        style = UIActivityIndicatorView.Style.large
    }
    
}
