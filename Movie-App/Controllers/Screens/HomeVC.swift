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

class HomeVC: LoadingVC  {
    
    let scrollView = UIScrollView()
    let contentView = HomeContentView()
    let selectionCarouselVC = SelectionCarousselVC()
    
    var fetchedMovies: FetchedMovies = FetchedMovies()
    var posterImages: PosterImages = PosterImages()
    var genres: [Genre]?
    
    var padding: CGFloat = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Dark-Gray")
        configure()
        getData()
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
    
    func getData() {
        showLoadingView()
        
        Task {
            do {
                let genres = try await NetworkManager.shared.getMovieGenres()
                let popularMovies = try await NetworkManager.shared.getMovies(requestName: .popularMovies)
                let moviesInTheatres = try await NetworkManager.shared.getMovies(requestName: .moviesInTheatres)
                let ratedMovies = try await NetworkManager.shared.getMovies(requestName: .ratedMovies)
                let upcomingMovies = try await NetworkManager.shared.getMovies(requestName: .upcomingMovies)
                
                updateUI(genres: genres.genres, popularMovies: popularMovies, moviesInTheatres: moviesInTheatres, ratedMovies: ratedMovies, upcomingMovies: upcomingMovies)
                
                dismissLoadingView()
            } catch {
                if let movieError = error as? MovieAppError {
                    print(movieError.rawValue)
                } else {
                    print("something went wrong?")
                }
                dismissLoadingView()
            }
        }
    }
    
    func updateUI(genres: [Genre], popularMovies: MoviesData, moviesInTheatres: MoviesData, ratedMovies: MoviesData, upcomingMovies: MoviesData) {
        selectionCarouselVC.updateCollectionView(genres: genres, popularMovies: popularMovies, moviesInTheatres: moviesInTheatres, ratedMovies: ratedMovies, upcomingMovies: upcomingMovies)
    }
    
}




