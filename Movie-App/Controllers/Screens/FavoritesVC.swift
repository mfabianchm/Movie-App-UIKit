//
//  FavoritesVC.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 23/05/24.
//

import UIKit

class FavoritesVC: UIViewController {

    var loadingView: UIView?
    
    let placeholderText = UILabel()
    let moviesTableView = UITableView()
    
    var numberOfCells: Int = 10
    var favorites: [Movie] = []
    
    var genres: [Genre]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Dark-Gray")
        configure()
        getGenres()
    }
    
    
    func configure() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        view.addSubview(placeholderText)
        configureTableView()
        placeholderText.text = "You don't have any favorites yet, go add some! 🏃‍♂️​"
        placeholderText.numberOfLines = 4
        placeholderText.font = UIFont(name: "Montserrat-SemiBold", size: 30)
        placeholderText.textColor = .gray
        placeholderText.textAlignment = .center
        placeholderText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            placeholderText.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            placeholderText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            placeholderText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            placeholderText.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func configureTableView() {
        view.addSubview(moviesTableView)
        
        moviesTableView.backgroundColor = UIColor(named: "Dark-Gray")
        moviesTableView.frame         = view.bounds
        moviesTableView.rowHeight     = 80
        moviesTableView.delegate      = self
        moviesTableView.dataSource    = self
        moviesTableView.removeExcessCells()
        moviesTableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    func  getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self else { return }
            
            switch result {
                case .success(let favorites):
                    self.updateUI(with: favorites)
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.presentGFAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                    }
            }
        }
    }
    
    func updateUI(with favorites: [Movie]) {
        if favorites.isEmpty {
            //            Show message in screen
            view.bringSubviewToFront(placeholderText)
//            self.showEmptyStateView(with: "No Favorites?\nAdd one on the follower screen.", in: self.view)
        } else  {
            self.favorites = favorites
            DispatchQueue.main.async {
                self.moviesTableView.reloadData()
                self.view.bringSubviewToFront(self.moviesTableView)
            }
        }
    }
    

    
//    func presentDetailsVC(movie: Movie) {
//        navigationController?.pushViewController(DetailsVC(infoMovie: movie, genres: self.genres!), animated: true)
//    }
    
    func getGenres() {
        Task {
            do {
                let genres = try await NetworkManager.shared.getMovieGenres()
                self.genres = genres.genres
                print(self.genres)
            } catch {
                if let movieError = error as? MovieAppError {
                    print(movieError.rawValue)
                } else {
                    print("something went wrong?")
                }
                
            }
        }
    }
}


extension FavoritesVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite    = favorites[indexPath.row]
        
        let VC = DetailsVC(infoMovie: favorite, genres: genres!)
        
        navigationController?.pushViewController(VC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self else { return }
            guard let error else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                if self.favorites.isEmpty {
                    print("There is no favorites")
//                    self.showEmptyStateView(with: "No Favorites?\nAdd one on the follower screen.", in: self.view)
                }
                return
            }
            
            DispatchQueue.main.async {
                self.presentGFAlert(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}
