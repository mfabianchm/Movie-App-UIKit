//
//  SelectionCarousselVC.swift
//  Movie-App
//
//  Created by Marcos Chong on 31/05/24.
//
//1.Crear uicollectionView y ponerla dentro de este controller

import UIKit

enum MovieType: String {
    case moviesInTheatres = ""
    case popularMovies = "movie/popular"
    case ratedMovies = "movie/top_rated"
    case upcomingMovies = "movie/upcoming"
}

class SelectionCarousselVC: UIViewController {
    
    let buttonsStackView = ButtonsStackView()
    let moviesCollectionView = MoviesCollectionView()
    let loadingVC = LoadingViewController()
    
    let buttonsText: [String] = ["Popular", "New", "Most-Rated", "Upcoming"]
    var buttons: [UIButton] = []
    
    let cellScale: CGFloat = 0.6
    let numberOfItems = 100
    var padding: CGFloat = 10

    var movieSelected: Movie?
    var centerCell: MovieCell?
    
    var fetchedMovies: FetchedMovies?
    var posterImages: PosterImages?
    var genres: [Genre]?
    
    var moviesToDisplay: [Movie]?
    var postersToDisplay: [UIImage]?
    
    var scrollToMiddle: Bool?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        configure()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (scrollToMiddle == false) {
            return
        }
        moviesCollectionView.scrollToItem(at: IndexPath(item: self.numberOfItems/2, section: 0), at: .centeredHorizontally, animated: true)
      }
    
    func configure() {
        configureStack()
        configureMoviesCollectionView()
        configureConstrainst()
    }
    
    func configureStack() {
        view.addSubview(buttonsStackView)
        configureButtons()
    }
    
    func configureButtons() {
        buttonsText.indices.forEach { index in
            let button = CarouselButton(title: buttonsText[index])
            button.tag = index
            button.addTarget(self, action: #selector(buttonChanged(_:)), for: .touchUpInside)
            buttons.append(button)
    
            if(index == 0) {
                button.isSelected = true
                button.underlineText()
            }
            
            buttonsStackView.addArrangedSubview(button)
        }
    }
    
    func configureMoviesCollectionView() {
        view.addSubview(moviesCollectionView)
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        moviesCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
    }
    
    func configureConstrainst() {
        NSLayoutConstraint.activate([
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            moviesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviesCollectionView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor),
            moviesCollectionView.heightAnchor.constraint(equalToConstant: 370),
        
        ])
    }
    
    
    @objc func buttonChanged(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            moviesToDisplay = fetchedMovies?.popularMovies
            postersToDisplay = posterImages?.popularMovies
            moviesCollectionView.reloadData()
        case 1:
            moviesToDisplay = fetchedMovies?.moviesInTheatres
            postersToDisplay = posterImages?.moviesInTheatres
            moviesCollectionView.reloadData()
        case 2:
            moviesToDisplay = fetchedMovies?.ratedMovies
            postersToDisplay = posterImages?.ratedMovies
            moviesCollectionView.reloadData()
        default:
            moviesToDisplay = fetchedMovies?.upcomingMovies
            postersToDisplay = posterImages?.upcomingMovies
            moviesCollectionView.reloadData()
        }

        buttons.forEach { btn in
            btn.isSelected = false
            btn.setTitleColor(.white, for: .normal)
            btn.normalText()
        }
        sender.isSelected = true
        sender.underlineText()
    }
    
   
    @objc func presentDetailsVC() {
        guard let genres = genres else {return}
        navigationController?.pushViewController(DetailsVC(model: movieSelected, genres: genres), animated: true)
    }
}


extension SelectionCarousselVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.button.addTarget(self, action: #selector(presentDetailsVC), for: .touchUpInside)

        if let movies = moviesToDisplay {
            let model = movies[indexPath.row % movies.count]
            let image = postersToDisplay![indexPath.row % movies.count]
            cell.configureData(model: model, posterImage: image)
        }
        return cell
    }
}



extension SelectionCarousselVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        scrollToMiddle = false
        let cellToSearch = collectionView.cellForItem(at: indexPath) as! MovieCell
        self.movieSelected = cellToSearch.model
        presentDetailsVC()
    }
}


extension SelectionCarousselVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            let sideInset = (collectionView.frame.size.width - 200) / 2
            return UIEdgeInsets(top: 0, left: sideInset, bottom: 0, right: sideInset)
        }
}



extension SelectionCarousselVC: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
      let layout = self.moviesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
      let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing

      var offset = targetContentOffset.pointee
      let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing

      let roundedIndex = round(index)

      offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)

      targetContentOffset.pointee = offset
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      guard scrollView is UICollectionView else {return}

      let centerCell: MovieCell?

      let centerPoint = CGPoint(x: self.moviesCollectionView.frame.size.width / 2 + scrollView.contentOffset.x,
                                y: self.moviesCollectionView.frame.size.height / 2 + scrollView.contentOffset.y)
      if let indexPath = self.moviesCollectionView.indexPathForItem(at: centerPoint) {
        self.centerCell = (self.moviesCollectionView.cellForItem(at: indexPath) as? MovieCell)
        self.centerCell?.transformToLarge()
      }

      if let cell = self.centerCell {
        let offsetX = centerPoint.x - cell.center.x
        if offsetX < -40 || offsetX > 40 {
          cell.transformToStandard()
          self.centerCell = nil
        }
      }
    }
}



