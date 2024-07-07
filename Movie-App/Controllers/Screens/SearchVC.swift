//
//  SearchVC.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 23/05/24.
//

import UIKit

class SearchVC: UIViewController {
    
    var loadingView: UIView?
    
    let searchBar = SearchBarView()
    let titleLabel = UILabel()
    let moviesTableView = UITableView()
    
    var numberOfCells: Int = 10
    var movies: [Movie]?
    var genres: [Genre]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Dark-Gray")
        configure()
        getGenres()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
        
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = UIColor(named: "Yellow")
        
    }
    
    func configure() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        
        view.addSubview(searchBar)
        view.addSubview(titleLabel)
        configureTableView()
        
        titleLabel.text = "Search your favorite movie! 😎​"
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 30)
        titleLabel.textColor = .gray
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 65),
            
            titleLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func configureTableView() {
        view.addSubview(moviesTableView)
        
        moviesTableView.alpha = 0
        moviesTableView.backgroundColor = UIColor(named: "Dark-Gray")
        moviesTableView.register(MovieSearchTVCell.self, forCellReuseIdentifier: "MovieSearchTVCell")
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            moviesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviesTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            moviesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func showTableView() {
        moviesTableView.alpha = 1
        self.numberOfCells = movies!.count
        moviesTableView.reloadData()
    }
    
    func presentDetailsVC(movie: Movie) {
        navigationController?.pushViewController(DetailsVC(infoMovie: movie, genres: self.genres!), animated: true)
    }
    
    func getGenres() {
        Task {
            do {
                let genres = try await NetworkManager.shared.getMovieGenres()
                self.genres = genres.genres
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

extension SearchVC: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_: UITableView, didSelectRowAt: IndexPath) {
        let movie: Movie = self.movies![didSelectRowAt.row]
        presentDetailsVC(movie: movie)
    }
}

extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieSearchTVCell", for: indexPath) as! MovieSearchTVCell
        
        guard let movies = self.movies else {
            return cell
        }
        
        
            let imagePath = movies[indexPath.row].posterPath
            let movieName = movies[indexPath.row].originalTitle
            let releaseDate = movies[indexPath.row].releaseDate
            
            cell.configureData(title: movieName, releaseDate: releaseDate, posterImage: imagePath)
            
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Results"
        }
}

extension SearchVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        showLoadingView()
        guard let movieToSearch = searchBar.text else {return}
        
        getData(movieToSearch: movieToSearch)
        
//        Task {
//            do {
//                let movieInfo = try await NetworkManager.shared.searchMovie(movieName: movieToSearch)
//                guard let movies: [Movie] = movieInfo?.results else {return}
//                self.movies = movies
//                showTableView()
//                
//                dismissLoadingView()
//                
//            } catch {
//                if let movieError = error as? MovieAppError {
//                    print(movieError.rawValue)
//                } else {
//                    print("something went wrong")
//                }
//                dismissLoadingView()
//            }
//            
//        }
    }

}

extension SearchVC {
    func showLoadingView() {
        loadingView = UIView()
        view.addSubview(loadingView!)
        
        loadingView!.backgroundColor   = .black
        loadingView!.alpha             = 0
        
        UIView.animate(withDuration: 0.25) { self.loadingView!.alpha = 0.9 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        loadingView!.addSubview(activityIndicator)
        
        loadingView!.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loadingView!.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            loadingView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView!.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerYAnchor.constraint(equalTo: loadingView!.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: loadingView!.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        guard let loadingView = loadingView else {return}
        
        DispatchQueue.main.async {
            loadingView.removeFromSuperview()
            self.loadingView = nil
        }
    }
    
    func getData(movieToSearch: String) {
        print("ahhhhh")
        Task {
            do {
                let movieInfo = try await NetworkManager.shared.searchMovie(movieName: movieToSearch)
                guard let movies: [Movie] = movieInfo?.results else {return}
                self.movies = movies
                showTableView()
                
                dismissLoadingView()
                
            } catch {
                if let movieError = error as? MovieAppError {
                    print(movieError.rawValue)
                } else {
                    print("something went wrong")
                }
                dismissLoadingView()
            }
            
        }
    }
    
}
