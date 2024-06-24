//
//  CastCollectionView.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 23/06/24.
//

import UIKit

class CastCollectionView: UICollectionView {

    let layout = UICollectionViewFlowLayout()
    
    init() {
        super.init(frame: .zero, collectionViewLayout: layout)
        layout.itemSize = .init(width: 100, height: 100)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
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




