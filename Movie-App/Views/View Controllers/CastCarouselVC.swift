//
//  CastCarouselVC.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 23/06/24.
//

import UIKit

class CastCarouselVC: UIViewController {
//
//    let titleLabel = UILabel()
//    let castCollectionView = CastCollectionView()
//
//    let cellScale: CGFloat = 0.6
//    let numberOfCells = 10
//
//    var padding: CGFloat = 10
//    var centerCell: MovieCell?
//
//    var movieId: Int
//
//    var imagesName: [String] = []
//    var actors: [String] = []
//    var characters: [String] = []
    
    let castInfo: Cast
    
    init(cast: Cast) {
        self.castInfo = cast
        super.init(nibName: nil, bundle: nil)
        print(castInfo)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
//        getMovieCast()
//        configure()
    }
        
//    func configure() {
//        configureCastCollectionView()
//        configureTitleLabel()
//        configureConstrainst()
//    }
//
//
//    func configureCastCollectionView() {
//        view.addSubview(castCollectionView)
//        castCollectionView.dataSource = self
//        castCollectionView.delegate = self
//        castCollectionView.register(CastCell.self, forCellWithReuseIdentifier: "CastCell")
//    }
//
//    func configureTitleLabel() {
//        view.addSubview(titleLabel)
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.text = "Film crew"
//        titleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 16)
//        titleLabel.textColor = .white
//    }
//
//    func configureConstrainst() {
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
//            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//
//            castCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            castCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            castCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            castCollectionView.heightAnchor.constraint(equalToConstant: 100),
//        ])
//    }
}



//extension CastCarouselVC: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//            return self.images.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCell", for: indexPath) as! CastCell
//
//        if(self.actors.count == 0 && self.characters.count == 0) {
//            return cell
//        }
//
//        let image: UIImage
//
//        if(self.images.isEmpty) {
//            image = UIImage(systemName: "person.fill")!
//        } else {
//            image = self.images[indexPath.row]
//        }
//
//        let actor = self.actors[indexPath.row]
//        let character = self.characters[indexPath.row]
//        cell.configureData(image: image, name: actor, character: character)
//        return cell
//    }
//}
//
//extension CastCarouselVC: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView,
//                        didSelectItemAt indexPath: IndexPath) {
//       print("cell clicked")
//    }
//}


extension CastCarouselVC {

//    func getImages() {
////        if(self.imagesName.isEmpty) {
////            return
////        }
//
//        self.imagesName.forEach { path in
//            let imagePath = path
//            let url = URL(string: "https://image.tmdb.org/t/p/original\(imagePath)")!
//
//            NetworkManager.shared.getImage(from: url) { data, response, error in
//                guard let data = data, error == nil else { return }
//                let image = UIImage(data: data)
//
//                guard let image = image else {
//                    self.images.append(UIImage(systemName: "person.fill")!)
//                    return
//                }
//
//                self.images.append(image)
//
//                DispatchQueue.main.async {
//                    self.castCollectionView.reloadData()
//                }
//            }
//        }
//    }
}
