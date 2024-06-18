//
//  NavigationView.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 24/05/24.
//

import UIKit

class NavigationView: UIView{

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit(){
        addSubview(mainView)
        mainView.addSubview(collectionView)
        setConstraints()
    }
    func setConstraints() {
        let constraints = [
            mainView.topAnchor.constraint(equalTo: topAnchor),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor),

            collectionView.topAnchor.constraint(equalTo: mainView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)

    }

    public let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.register(NavigationCell.self, forCellWithReuseIdentifier: "NavigationCell")
        v.backgroundColor = .clear
        return v
    }()

    public let mainView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(named: "Dark-Gray")
        return v
    }()

}
