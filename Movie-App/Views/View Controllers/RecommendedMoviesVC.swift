//
//  RecommendedMoviesVC.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 01/07/24.
//

import UIKit

class RecommendedMoviesVC: UIViewController {

    let titleLabel = UILabel()
    let collectionView = RecommendedMoviesCollectionView()
    
    var movies: [Movie] = []

    var numberOfCells = 10
    
    var padding: CGFloat = 10
    
    var images: [UIImage] = []
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        configure()
    }
        
    func configure() {
        configureCastCollectionView()
        configureTitleLabel()
        configureConstrainst()
    }
    
    
    func configureCastCollectionView() {
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(RecommendedMoviesCell.self, forCellWithReuseIdentifier: "RecommendedMoviesCell")
    }
    
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "What else to see"
        titleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        titleLabel.textColor = .white
    }
    
    func configureConstrainst() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 350),
        ])
    }
}

extension RecommendedMoviesVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedMoviesCell", for: indexPath) as! RecommendedMoviesCell

        if(self.movies.count == 0) {
            return cell
        } else {
            let image = self.movies[indexPath.row].posterPath
            let title = self.movies[indexPath.row].originalTitle
            cell.configureData(title: title, posterImage: image!)
            return cell
        }
        
        return cell
    }
    

}


extension RecommendedMoviesVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
       print("cell clicked")
    }
}

extension RecommendedMoviesVC {
    
    func updateRecommendedMoviesVC(movies: [Movie]) {
        movies.forEach { movie in
            self.movies.append(movie)
        }
        
        self.numberOfCells = self.movies.count
        collectionView.reloadData()
    }
}
