//
//  CastCarouselVC.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 23/06/24.
//

import UIKit

class CastCarouselVC: UIViewController {

    let titleLabel = UILabel()
    let castCollectionView = CastCollectionView()

    var numberOfCells = 10

    var padding: CGFloat = 10
    var centerCell: MovieCell?

    var imagesName: [String] = []
    var actors: [String] = []
    var characters: [String] = []

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
        view.addSubview(castCollectionView)
        castCollectionView.dataSource = self
        castCollectionView.delegate = self
        castCollectionView.register(CastCell.self, forCellWithReuseIdentifier: "CastCell")
    }

    func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Film crew"
        titleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        titleLabel.textColor = .white
    }

    func configureConstrainst() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),

            castCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            castCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            castCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            castCollectionView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}



extension CastCarouselVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return numberOfCells
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCell", for: indexPath) as! CastCell

        if(self.actors.count == 0 && self.characters.count == 0) {
            return cell
        } else {
            let actor = self.actors[indexPath.row]
            let character = self.characters[indexPath.row]
            let image = self.imagesName[indexPath.row]
            cell.configureData(name: actor, character: character, urlPath: image)
            return cell
        }
    }
}

extension CastCarouselVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
       print("cell clicked")
    }
}


extension CastCarouselVC {
    
    func updateCastCarousel(cast: Cast) {
        cast.cast.forEach { person in
            self.actors.append(person.name)
            self.characters.append(person.character)
            self.imagesName.append(person.profilePath ?? "no-image")
        }
        
        self.numberOfCells = cast.cast.count
        castCollectionView.reloadData()
        
    }

}
