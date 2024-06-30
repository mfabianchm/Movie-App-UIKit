//
//  MovieImagesCollectionView.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 24/06/24.
//

import UIKit

class MovieImagesCollectionView: UICollectionView {

    let layout = UICollectionViewFlowLayout()
    
    init() {
        super.init(frame: .zero, collectionViewLayout: layout)
        layout.itemSize = .init(width: 80, height: 80)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
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
