//
//  MovieImagesCarouselVC.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 24/06/24.
//

import UIKit

class MovieImagesCarouselVC: UIViewController {

    let titleLabel = UILabel()
    let collectionView = MoviesCollectionView()

    let numberOfCells = 10
    
    var padding: CGFloat = 10
    
    var movieId: Int
    var images: [UIImage] = []
    
    init(movieId: Int) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
//        getMovieImages()
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
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
//    func getMovieImages() {
//        NetworkManager.shared.getMovieImages(movie_id: movieId) { result in
//            switch result {
//            case .success(let moviesArray):
//                self.images = moviesArray
//                print(moviesArray)
////                DispatchQueue.main.async {
////                    self.movieDetails = movie
////                    self.configureInfoMovieStackView()
////                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
}

extension MovieImagesCarouselVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieImageCell", for: indexPath) as! MovieImageCell
        
        let image: UIImage
        
        if(self.images.isEmpty) {
            image = UIImage(systemName: "person.fill")!
        } else {
            image = self.images[indexPath.row]
        }
        
        cell.configureData(image: image)
        return cell
    }
}

extension MovieImagesCarouselVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
       print("cell clicked")
    }
}
