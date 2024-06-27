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
    var castCarouselVC: CastCarouselVC?
    var movieImagesCarouselVC: MovieImagesCarouselVC?
    
    var padding: CGFloat = 10
    
    var posterImage: UIImage?
    var movieGenres: [String]?
    
    let model: Movie?
    let genres: [Genre]?
    let details: MovieDetails?
    let images: [UIImage]?
    let cast: Cast?
    
    var movieGenresId: [Int]?


    init(infoMovie: Movie?, genres: [Genre], details: MovieDetails, images: [UIImage], cast: Cast) {
        self.model = infoMovie
        self.genres = genres
        self.details = details
        self.images = images
        self.cast = cast
        super.init(nibName: nil, bundle: nil)
        setMovieGenres()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView = DetailsContentView(model: model!, genres: movieGenres!, details: details!, images: images!, cast: cast!)
        castCarouselVC = CastCarouselVC(cast: cast!)
//        movieImagesCarouselVC = MovieImagesCarouselVC(movieId: model!.id)
//
        addVCChilds()
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
    
    func addVCChilds() {
        addChild(castCarouselVC!)
//        addChild(movieImagesCarouselVC!)
        
//        guard let contentView = contentView as? DetailsContentView else {return}
//
//        contentView.configureCastCarouselView(childView: castCarouselVC!.view)
//        contentView.configureCastCarouselView(childView: movieImagesCarouselVC!.view)
        castCarouselVC!.didMove(toParent: self)
//        movieImagesCarouselVC!.didMove(toParent: self)
    }
    
    func configure() {
        configureScrollView()
        addViews()
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
    
    
//    func configureInfoMovieStackView() {
//        let countriesString: String
//        let genresString = movieGenres.joined()
//        
//        if let countries = details?.originCountry {
//            countriesString = countries.joined(separator: ",")
//        } else {
//            countriesString = "N/A"
//        }
//        
//        guard let contentView = contentView as? DetailsContentView else {return}
//        
//        contentView.infoMovieStack.originalTitle =  model!.originalTitle
//        contentView.infoMovieStack.countriesString = countriesString
//        contentView.infoMovieStack.releaseDate = "\(model!.releaseDate)•\(genresString)"
//        contentView.infoMovieStack.originalLanguage = details?.originalLanguage
//        contentView.infoMovieStack.status = details?.status
//        
//        contentView.infoMovieStack.redrawView()
//        
//    }
    
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


