//
//  MovieImagesCarouselVC.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 24/06/24.
//

import UIKit

class MovieImagesCarouselVC: UIViewController {

    let titleLabel = UILabel()
    let collectionView = MovieImagesCollectionView()

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
        collectionView.register(MovieImageCell.self, forCellWithReuseIdentifier: "MovieImageCell")
    }
    
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Photo Gallery"
        titleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        titleLabel.textColor = .white
    }
    
    func configureConstrainst() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
}

extension MovieImagesCarouselVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieImageCell", for: indexPath) as! MovieImageCell

        if(self.images.count == 0) {
            return cell
        } else {
            let image = self.images[indexPath.row]
            cell.configureData(image: image)
            return cell
        }
    }
}

extension MovieImagesCarouselVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
       print("cell clicked")
    }
}

extension MovieImagesCarouselVC {
    
    func updateMovieImagesCarousel(images: [UIImage]) {
        images.forEach { image in
            self.images.append(image)
        }
        
        self.numberOfCells = self.images.count
        collectionView.reloadData()
    }
}
