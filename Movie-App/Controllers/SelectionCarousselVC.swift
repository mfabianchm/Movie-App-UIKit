//
//  SelectionCarousselVC.swift
//  Movie-App
//
//  Created by Marcos Chong on 31/05/24.
//
//1.Crear uicollectionView y ponerla dentro de este controller

import UIKit

struct MovieTest {
    let title: String
    let imageMovie: String
}

class SelectionCarousselVC: UIViewController {
    
    let buttonsText: [String] = ["Popular", "New", "Premieres", "Random"]
    let buttonsStackView = UIStackView()
    
    let moviesCollectionView = MoviesCollectionView()
    
    let moviesArray: [MovieTest] = [
        MovieTest(title: "Joker", imageMovie: "joker-image"),
        MovieTest(title: "Joker", imageMovie: "joker-image"),
        MovieTest(title: "Joker", imageMovie: "joker-image"),
        MovieTest(title: "Joker", imageMovie: "joker-image"),
        MovieTest(title: "Joker", imageMovie: "joker-image"),
    ]
    
    var popularMovies: [Movie]?
    var buttons: [UIButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
//        getPopularMovies()
        configure()
    }
    
    func configure() {
        configureStack()
        configureButtons()
        configureMoviesCollectionView()
        configureConstrainst()
    }
    
    func configureStack() {
        view.addSubview(buttonsStackView)
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.axis = .horizontal
        buttonsStackView.distribution = .equalSpacing
    }
    
    func configureButtons() {
        buttonsText.indices.forEach { index in
            let button = UIButton()
            button.setTitle(buttonsText[index], for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.setTitleColor(UIColor(named: "Yellow"), for: .selected)
            button.addTarget(self, action: #selector(buttonChanged(_:)), for: .touchUpInside)
            buttons.append(button)
    
            if(index == 0) {
                button.isSelected = true
                button.underlineText()
            }
            
            buttonsStackView.addArrangedSubview(button)
        }
    }
    
    func configureConstrainst() {
        NSLayoutConstraint.activate([
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            moviesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviesCollectionView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor),
            moviesCollectionView.heightAnchor.constraint(equalToConstant: 370)
        ])
    }
    
    func configureMoviesCollectionView() {
        view.addSubview(moviesCollectionView)
        moviesCollectionView.backgroundColor = .blue
        moviesCollectionView.dataSource = self
        moviesCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        moviesCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func buttonChanged(_ sender: UIButton) {
        buttons.forEach { btn in
            btn.isSelected = false
            btn.setTitleColor(.white, for: .normal)
            btn.normalText()
        }
        sender.isSelected = true
        sender.underlineText()
    }
    
    func getPopularMovies() {
        NetworkManager.shared.getMovies(requestName: .popularMovies) { result in
            switch result {
               case .success(let movies):
                self.popularMovies = movies.results
                print(self.popularMovies)
               case .failure(let error):
                   print(error.localizedDescription)
               }
        }
    }
}

extension SelectionCarousselVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        moviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.backgroundColor = .red
        let model = moviesArray[indexPath.row]
        cell.configureData(model: model)
                          
        return cell
    }
    
    
}
