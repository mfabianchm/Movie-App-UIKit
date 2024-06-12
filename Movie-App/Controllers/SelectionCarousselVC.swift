//
//  SelectionCarousselVC.swift
//  Movie-App
//
//  Created by Marcos Chong on 31/05/24.
//
//1.Crear uicollectionView y ponerla dentro de este controller

import UIKit

//struct MovieTest {
//    let title: String
//    let imageMovie: String
//}

class SelectionCarousselVC: UIViewController {
    
    let buttonsText: [String] = ["Popular", "New", "Most-Rated", "Upcoming"]
    let buttonsStackView = UIStackView()
    let cellScale: CGFloat = 0.6
    let numberOfItems = 100
    
    var spinner: UIActivityIndicatorView = LoadingView(frame: CGRect(x: 0, y: 0, width: 40, height:40))
    var centerCell: MovieCell?
    
    let moviesCollectionView = MoviesCollectionView()
    
//    let moviesArray: [MovieTest] = [
//        MovieTest(title: "Joker", imageMovie: "joker-image"),
//        MovieTest(title: "Toy Story 2", imageMovie: "joker-image"),
//        MovieTest(title: "La dama y el vagabundo", imageMovie: "joker-image"),
//        MovieTest(title: "Joker", imageMovie: "joker-image"),
//        MovieTest(title: "Joker", imageMovie: "joker-image"),
//    ]
    
    var fetchedMovies: [Movie]?
    var posterImages: [UIImage]?
    
    var buttons: [UIButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        getPopularMovies()
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        moviesCollectionView.scrollToItem(at: IndexPath(item: self.numberOfItems/2, section: 0), at: .centeredHorizontally, animated: true)
      }
    
    func configure() {
        self.configureStack()
        self.configureButtons()
        self.configureMoviesCollectionView()
        self.configureConstrainst()
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
            button.tag = index
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
            moviesCollectionView.heightAnchor.constraint(equalToConstant: 370),
        ])
    }
    
    func configureMoviesCollectionView() {
        view.addSubview(moviesCollectionView)
        moviesCollectionView.backgroundColor = .blue
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        
        moviesCollectionView.alwaysBounceHorizontal = true
        moviesCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        moviesCollectionView.showsHorizontalScrollIndicator = false
        moviesCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }

    
    @objc func buttonChanged(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            getPopularMovies()
            showLoader()
        case 1:
            getNewMovies()
            showLoader()
        case 2:
            getMostRatedMovies()
            showLoader()
        default:
            getUpcomingMovies()
            showLoader()
        }
        
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
                self.fetchedMovies = movies.data
                self.posterImages = movies.posterImages
                DispatchQueue.main.async {
                    self.moviesCollectionView.reloadData()
                }
               case .failure(let error):
                   print(error.localizedDescription)
               }
        }
    }
    
    func getNewMovies() {
        NetworkManager.shared.getMovies(requestName: .moviesInTheatres) { result in
            switch result {
               case .success(let movies):
                self.fetchedMovies = movies.data
                self.posterImages = movies.posterImages
                DispatchQueue.main.async {
                    self.moviesCollectionView.reloadData()
                }
               case .failure(let error):
                   print(error.localizedDescription)
               }
        }
    }
    
    func getMostRatedMovies() {
        NetworkManager.shared.getMovies(requestName: .ratedMovies) { result in
            switch result {
               case .success(let movies):
                self.fetchedMovies = movies.data
                self.posterImages = movies.posterImages
                DispatchQueue.main.async {
                    self.moviesCollectionView.reloadData()
                }
               case .failure(let error):
                   print(error.localizedDescription)
               }
        }
    }
    
    func getUpcomingMovies() {
        NetworkManager.shared.getMovies(requestName: .upcomingMovies) { result in
            switch result {
               case .success(let movies):
                self.fetchedMovies = movies.data
                self.posterImages = movies.posterImages
                DispatchQueue.main.async {
                    self.moviesCollectionView.reloadData()
                }
               case .failure(let error):
                   print(error.localizedDescription)
               }
        }
    }
    
    func showLoader() {
        view.addSubview(spinner)
        spinner.startAnimating()
        view.isUserInteractionEnabled = false
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func dismissLoader() {
        spinner.stopAnimating()
        view.isUserInteractionEnabled = true
    }
    
    @objc func presentDetailsVC() {
        navigationController?.pushViewController(DetailsVC(), animated: true)
    }

}

extension SelectionCarousselVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(fetchedMovies == nil) {
            view.alpha = 0.5
            showLoader()
        } else {
            view.alpha = 1
            dismissLoader()
        }
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.button.addTarget(self, action: #selector(presentDetailsVC), for: .touchUpInside)
        
        if let movies = fetchedMovies {
            let model = movies[indexPath.row % movies.count]
            let image = posterImages![indexPath.row % movies.count]
            cell.configureData(model: model, posterImage: image)
        }
        return cell
    }
}

extension SelectionCarousselVC: UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            let sideInset = (collectionView.frame.size.width - 200) / 2
            return UIEdgeInsets(top: 0, left: sideInset, bottom: 0, right: sideInset)
        }
    
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
