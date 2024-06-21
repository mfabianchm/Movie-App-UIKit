//
//  HomeVC.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 23/05/24.
//

import UIKit

struct FetchedMovies {
    var popularMovies: [Movie]?
    var moviesInTheatres: [Movie]?
    var ratedMovies: [Movie]?
    var upcomingMovies: [Movie]?
}

struct PosterImages {
    var popularMovies: [UIImage]?
    var moviesInTheatres: [UIImage]?
    var ratedMovies: [UIImage]?
    var upcomingMovies: [UIImage]?
}

class HomeVC: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = HomeContentView()
    let selectionCarouselVC = SelectionCarousselVC()
    let loadingVC = LoadingViewController()
    
    var fetchedMovies: FetchedMovies = FetchedMovies()
    var posterImages: PosterImages = PosterImages()
    var genres: [Genre]?
    
    var padding: CGFloat = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Dark-Gray")

        getGenres()
        getMovies(type: .popularMovies)
        getMovies(type: .moviesInTheatres)
        getMovies(type: .ratedMovies)
        getMovies(type: .upcomingMovies)
        configure()
        
        if(fetchedMovies.popularMovies == nil) {
            self.add(loadingVC)
            view.isUserInteractionEnabled = false
            NSLayoutConstraint.activate([
                loadingVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                loadingVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                loadingVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                loadingVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            ])
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let textFieldInsideSearchBar = contentView.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white

        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = UIColor(named: "Yellow")
        
        
    }
    
    func configure() {
        view.addSubview(scrollView)
        configureScrollView()
        configureSearchBarDelegate()
        addVCChilds()
        configureConstrainst()
    }
    
    
    func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(named: "Dark-Gray")
        scrollView.addSubview(contentView)
    }
    
    func configureSearchBarDelegate() {
        contentView.searchBar.searchTextField.delegate = self
    }
    
    
    func addVCChilds() {
        self.add(selectionCarouselVC)
    }
    
    func configureConstrainst() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: 0),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: 0),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 2000),
            
            selectionCarouselVC.view.topAnchor.constraint(equalTo: contentView.searchBar.bottomAnchor, constant: 10),
            selectionCarouselVC.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            selectionCarouselVC.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            selectionCarouselVC.view.heightAnchor.constraint(equalToConstant: 400)
            
        ])
    }
}



extension HomeVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return button pressed")
        return true
    }
}


extension HomeVC {
    func getMovies(type: EndPoint) {
        
        let requestName: EndPoint
        let movieType: String
        
        switch type {
        case .popularMovies:
            requestName = type
            movieType = "popular"
        case .moviesInTheatres:
            requestName = type
            movieType = "inTheatres"
        case .ratedMovies:
            requestName = type
            movieType = "rated"
        case .upcomingMovies:
            requestName = type
            movieType = "upcoming"
        }
        
        NetworkManager.shared.getMovies(requestName: requestName) { result in
            switch result {
               case .success(let movies):
                
                if(movieType == "popular") {
                    self.fetchedMovies.popularMovies = movies.data
                    self.posterImages.popularMovies = movies.posterImages
                }
                if(movieType == "inTheatres") {
                    self.fetchedMovies.moviesInTheatres = movies.data
                    self.posterImages.moviesInTheatres = movies.posterImages
                }
                if(movieType == "rated") {
                    self.fetchedMovies.ratedMovies = movies.data
                    self.posterImages.ratedMovies = movies.posterImages
                }
                else {
                    self.fetchedMovies.upcomingMovies = movies.data
                    self.posterImages.upcomingMovies = movies.posterImages
                    DispatchQueue.main.async {
                        self.selectionCarouselVC.fetchedMovies = self.fetchedMovies
                        self.selectionCarouselVC.posterImages = self.posterImages
                    
                        self.selectionCarouselVC.moviesToDisplay = self.selectionCarouselVC.fetchedMovies?.popularMovies
                        self.selectionCarouselVC.postersToDisplay = self.selectionCarouselVC.posterImages?.popularMovies
                        
                        self.selectionCarouselVC.moviesCollectionView.reloadData()
                        self.loadingVC.remove()
                        self.view.isUserInteractionEnabled = true
                    }
                }
               case .failure(let error):
                   print(error.localizedDescription)
               }
        }
        
    }
    
    func getGenres() {
        NetworkManager.shared.getMoviesGenres { result in
            switch result {
               case .success(let genres):
                self.genres = genres.genres
                self.selectionCarouselVC.genres = genres.genres
                
               case .failure(let error):
                   print(error.localizedDescription)
               }
        }
    }
}


