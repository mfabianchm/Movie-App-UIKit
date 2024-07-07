//
//  FavoritesVC.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 23/05/24.
//

import UIKit

class FavoritesVC: UIViewController {

    var loadingView: UIView?
    
    let titleLabel = UILabel()
//    let moviesTableView = UITableView()
    
    var numberOfCells: Int = 10
//    var movies: [Movie]?
//    var genres: [Genre]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Dark-Gray")
        configure()
//        getGenres()
    }
    
    
    func configure() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        view.addSubview(titleLabel)
//        configureTableView()
        titleLabel.text = "You don't have any favorites yet, go add some! 🏃‍♂️​"
        titleLabel.numberOfLines = 4
        titleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 30)
        titleLabel.textColor = .gray
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
//    func configureTableView() {
//        view.addSubview(moviesTableView)
//        
//        moviesTableView.alpha = 0
//        moviesTableView.backgroundColor = UIColor(named: "Dark-Gray")
//        moviesTableView.register(MovieSearchTVCell.self, forCellReuseIdentifier: "MovieSearchTVCell")
//        moviesTableView.delegate = self
//        moviesTableView.dataSource = self
//        moviesTableView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            moviesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            moviesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            moviesTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
//            moviesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//        ])
//    }
    
//    func showTableView() {
//        moviesTableView.alpha = 1
//        self.numberOfCells = movies!.count
//        moviesTableView.reloadData()
//    }
    
//    func presentDetailsVC(movie: Movie) {
//        navigationController?.pushViewController(DetailsVC(infoMovie: movie, genres: self.genres!), animated: true)
//    }
    
//    func getGenres() {
//        Task {
//            do {
//                let genres = try await NetworkManager.shared.getMovieGenres()
//                self.genres = genres.genres
//            } catch {
//                if let movieError = error as? MovieAppError {
//                    print(movieError.rawValue)
//                } else {
//                    print("something went wrong?")
//                }
//                
//            }
//        }
//    }
}
