//
//  RecommendedMoviesCollectionView.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 01/07/24.
//

import UIKit

class RecommendedMoviesCollectionView: UICollectionView {
    
    let layout = UICollectionViewFlowLayout()
    
    init() {
        super.init(frame: .zero, collectionViewLayout: layout)
        layout.itemSize = .init(width: 200, height: 300)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 30
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.showsHorizontalScrollIndicator = false
        self.alwaysBounceHorizontal = true
        self.backgroundColor = UIColor(named: "Dark-Gray")
    }

}
