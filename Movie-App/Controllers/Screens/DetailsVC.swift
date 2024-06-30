//
//  DetailsVC.swift
//  Movie-App
//
//  Created by Marcos Chong on 11/06/24.
//

import UIKit


class DetailsVC: LoadingVC {
    
    let mainView = DetailsContentView()
    
    let castCarouselVC = CastCarouselVC()
    let movieImagesCarouselVC = MovieImagesCarouselVC()
    
    var padding: CGFloat = 10
    
    var posterImage: UIImage?
    var movieGenres: [String]?
    
    let model: Movie?
    let genres: [Genre]?
    var details: MovieDetails?
    var images: [UIImage]?
    var cast: Cast?
    
    var movieGenresId: [Int]?

    init(infoMovie: Movie?, genres: [Genre]) {
        self.model = infoMovie
        self.genres = genres
        super.init(nibName: nil, bundle: nil)
        setMovieGenres()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieInfo()
        addVCChilds()
    }
    
    
//    override func viewWillAppear(_ animated: Bool){
//        super.viewWillAppear(animated)
////        self.navigationController?.isNavigationBarHidden = true
//    }
    
//    override func viewWillDisappear(_ animated: Bool){
//        super.viewWillDisappear(animated)
//        self.navigationController?.isNavigationBarHidden = false
//       }
    
    func addVCChilds() {
        self.add(castCarouselVC)
        self.add(movieImagesCarouselVC)
        
        mainView.configureVCChildsContrains(carouselView: castCarouselVC.view, movieImagesView: movieImagesCarouselVC.view)
    }
    
//    func configureVCChildsContrains() {
//        NSLayoutConstraint.activate([
//            castCarouselVC.view.topAnchor.constraint(equalTo: mainView.infoMovieStack.bottomAnchor, constant: 10),
//            castCarouselVC.view.leadingAnchor.constraint(equalTo: mainView.infoMovieStack.leadingAnchor),
//            castCarouselVC.view.trailingAnchor.constraint(equalTo: mainView.infoMovieStack.trailingAnchor),
//            castCarouselVC.view.heightAnchor.constraint(equalToConstant: 140),
//        ])
//    }
    
//    func configure() {
//        configureScrollView()
//        addViews()
//        configureConstrainst()
//    }
        
    func setMovieGenres() {
        
        guard let model = model else {return}
     
        var genresIds: [Int] = model.genreIds
        var genresArray: [String] = []
        
        if(genresIds.count > 2) {
            let lastElement = genresIds.count - 1
            genresIds.removeSubrange(2...lastElement)
        }
        
        genresIds.forEach { id in
            genres?.forEach { genre in
                if(genre.id) == id {
                    genresArray.append(genre.name)
                }
            }
        }
        
        self.movieGenres = genresArray
                
    }
}


extension DetailsVC {
    func getMovieInfo() {
        showLoadingView()
        
        Task {
            do {
                async let movieDetails = try await NetworkManager.shared.getMovieDetails(id: model!.id)
                async let movieImages = try await NetworkManager.shared.getMovieImages(id: model!.id)
                async let movieCast = try await NetworkManager.shared.getCastInfo(id: model!.id)
                
                let(details, images, cast) = await (try movieDetails, try movieImages, try movieCast)
                
                guard let details = details else {return}
                guard let images = images else {return}
                guard let cast = cast else {return}
                
                self.details = details
                self.images = images
                self.cast = cast
                
                mainView.updateUI(model: model!, genres: movieGenres!, movieDetails: details, movieImages: images, movieCast: cast)
                dismissLoadingView()
                castCarouselVC.updateCastCarousel(cast: cast)
                movieImagesCarouselVC.updateMovieImagesCarousel(images: images)
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
}


