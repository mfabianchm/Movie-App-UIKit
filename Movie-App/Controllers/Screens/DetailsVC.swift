//
//  DetailsVC.swift
//  Movie-App
//
//  Created by Marcos Chong on 11/06/24.
//

import UIKit

class DetailsVC: UIViewController {
    
    let scrollView = UIScrollView()
    var contentView: UIView?
    
    var padding: CGFloat = 10
    
    var posterImage: UIImage?
    var movieGenres: [String] = []
    let model: Movie?
    
    let genres: [Genre]?
    var movieGenresId: [Int]?
    var cast: [Person]?
    
    var movieDetails: MovieDetails?

    init(model: Movie?, genres: [Genre]) {
        self.model = model
        self.genres = genres
        self.movieGenresId = model?.genreIds
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMovieGenres()
        getImage()
        getMovieCast()
        getMovieDetails()
        contentView = DetailsContentView(model: model!, genres: movieGenres)
        configure()
    }
    
//    override func viewWillAppear(_ animated: Bool){
//        super.viewWillAppear(animated)
////        self.navigationController?.isNavigationBarHidden = true
//    }
    
//    override func viewWillDisappear(_ animated: Bool){
//        super.viewWillDisappear(animated)
//        self.navigationController?.isNavigationBarHidden = false
//       }
    
    func configure() {
        configureScrollView()
        addViews()
//        configureInfoMovieStackView()
        configureConstrainst()
    }
    
    func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(named: "Dark-Gray")
    }
    
    func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView!)
    }
    
    
    func setMovieGenres() {
        if(movieGenresId!.count > 2) {
            let lastElement = movieGenresId!.count - 1
            movieGenresId!.removeSubrange(2...lastElement)
        }
        
        movieGenresId?.forEach { id in
            genres?.forEach { genre in
                if(genre.id) == id {
                    movieGenres.append(genre.name)
                }
            }
        }
        
    }
    
    
    func configureInfoMovieStackView() {
        let countriesString: String
        let genresString = movieGenres.joined()
        
        if let countries = movieDetails?.originCountry {
            countriesString = countries.joined(separator: ",")
        } else {
            countriesString = "N/A"
        }
        
        guard let contentView = contentView as? DetailsContentView else {return}
        
        contentView.infoMovieStack.originalTitle =  model!.originalTitle
        contentView.infoMovieStack.countriesString = countriesString
        contentView.infoMovieStack.releaseDate = "\(model!.releaseDate)•\(genresString)"
        contentView.infoMovieStack.originalLanguage = movieDetails?.originalLanguage
        contentView.infoMovieStack.status = movieDetails?.status
        
        contentView.infoMovieStack.redrawView()
        
    }
    
    func configureConstrainst() {
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView!.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: 0
                                        ),
            contentView!.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView!.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 0),
            contentView!.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: 0),
            contentView!.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentView!.heightAnchor.constraint(equalToConstant: 2000),
            
        ])
    }
}

extension DetailsVC {
    
    func getMovieDetails() {
        NetworkManager.shared.getMovieDetails(id: model!.id) { result in
            switch result {
            case .success(let movie):
                DispatchQueue.main.async {
                    self.movieDetails = movie
                    self.configureInfoMovieStackView()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getMovieCast() {
        NetworkManager.shared.getCastInfo(movie_id: model!.id) { result in
            switch result {
            case .success(var cast):
                DispatchQueue.main.async {
                    if(cast.cast.count > 10) {
                        let lastElement = cast.cast.count - 1
                        cast.cast.removeSubrange(10...lastElement)
                    }
                    self.cast = cast.cast
                    print(self.cast)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getImage() {
        guard let movieData = model else {return}
        guard let movieUrl = movieData.posterPath else {return}
        let url = URL(string: "https://image.tmdb.org/t/p/original\(movieUrl)")!
        
        NetworkManager.shared.getImage(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                guard let self = self else {return}
                guard let contentView = self.contentView as? DetailsContentView else {return}
                
                contentView.mainMovieImage.image = UIImage(data: data)
            }
        }
    }
}
