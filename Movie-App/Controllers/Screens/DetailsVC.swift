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
    let recommendedMoviesVC = RecommendedMoviesVC()
    
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
        self.add(recommendedMoviesVC)
        
        mainView.configureVCChildsContrains(carouselView: castCarouselVC.view, movieImagesView: movieImagesCarouselVC.view, recommendedMoviesView: recommendedMoviesVC.view)
    }
        
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
                async let videoId = try await NetworkManager.shared.downloadVideoId(movie_id: model!.id)
                async let movies = try await NetworkManager.shared.getMovies(requestName: .popularMovies)
                
                let(details, images, cast, idVideo, recommendedMovies) = await (try movieDetails, try movieImages, try movieCast, try videoId, try movies)
                
                guard let details = details else {return}
                guard let images = images else {return}
                guard let cast = cast else {return}
                
                self.details = details
                self.images = images
                self.cast = cast
                
                mainView.updateUI(model: model!, genres: movieGenres!, movieDetails: details, movieImages: images, movieCast: cast)
                castCarouselVC.updateCastCarousel(cast: cast)
                movieImagesCarouselVC.updateMovieImagesCarousel(images: images)
                mainView.videoPlayer.load(withVideoId: idVideo!)
                recommendedMoviesVC.updateRecommendedMoviesVC(movies: recommendedMovies.data)
//                dismissLoadingView()
                
            } catch {
                if let movieError = error as? MovieAppError {
                    print(movieError.rawValue)
                } else {
                    print("something went wrong?")
//                    dismissLoadingView()
                }
            }
        }
    }
}


