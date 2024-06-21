//
//  DetailsVC.swift
//  Movie-App
//
//  Created by Marcos Chong on 11/06/24.
//


//We used this data: posterImage, movieGenres, model

import UIKit

class DetailsVC: UIViewController {
    
    let scrollView = UIScrollView()
    var contentView: UIView?
    
    let genresStackView = UIStackView()
    let rankingLabel = UILabel()
    let iconsStack = UIStackView()
    let infoMovieStack = UIStackView()
        
    var padding: CGFloat = 10
    
    var posterImage: UIImage?
    var movieGenres: [String] = []
    let model: Movie?
    
    
    let genres: [Genre]?
    var movieGenresId: [Int]?
    
    
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
//        configureContentView()
//        configureProfileImage()
//        configureMainImage()
//        configureGenresStackView()
//        configureRankingLabel()
//        configureIconsStackView()
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
    
    func configureGenresStackView() {
        
//        if(movieGenresId!.count > 2) {
//            let lastElement = movieGenresId!.count - 1
//            movieGenresId!.removeSubrange(2...lastElement)
//        }
//
//        movieGenresId?.forEach { id in
//            genres?.forEach { genre in
//                if(genre.id) == id {
//                    movieGenres.append(genre.name)
//                }
//            }
//        }
        
        movieGenres.forEach { genre in
            let genreLabel: UILabel = {
                let label = UILabel()
                label.backgroundColor = UIColor.black.withAlphaComponent(0.3)
                label.font = UIFont(name: "Montserrat-Medium", size: 13)
                label.textColor = .white
                label.layer.cornerRadius = 5
                label.layer.masksToBounds = true
                label.textAlignment = .center
                return label
            }()
            
            genreLabel.text = genre
            genresStackView.addArrangedSubview(genreLabel)
        }
        
        genresStackView.axis = .horizontal
        genresStackView.spacing = 5
        genresStackView.alignment = .fill
        genresStackView.distribution = .fillProportionally
        genresStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(genresStackView)
    }
    
    func configureRankingLabel() {
        rankingLabel.translatesAutoresizingMaskIntoConstraints = false
        rankingLabel.backgroundColor = UIColor(named: "Yellow")
        rankingLabel.textColor = .gray
        rankingLabel.layer.cornerRadius = 5
        rankingLabel.layer.masksToBounds = true
        rankingLabel.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        rankingLabel.textAlignment = .center
        view.addSubview(rankingLabel)
        
        guard let model = model else {
            rankingLabel.text = "N/A"
            return
        }
        
        let ranking = String(format: "%.2f", model.voteAverage)
        
        let attributedString = NSMutableAttributedString(string: "IMDB \(ranking)/10")
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: 10))
        rankingLabel.attributedText = attributedString
    }
    
    func configureIconsStackView() {
        let iconsName: [String] = ["heart","square.and.arrow.up" ,"bookmark"]
        
        iconsName.forEach { icon in
            let button: UIButton = {
                let button = UIButton(type: .system)
                button.setImage(UIImage(systemName: icon), for: .normal)
                button.tintColor = .white
                return button
            }()
            
            iconsStack.addArrangedSubview(button)
        }
        
        iconsStack.axis = .horizontal
        iconsStack.spacing = 5
        iconsStack.alignment = .center
        iconsStack.distribution = .fillProportionally
        iconsStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(iconsStack)
    }
    
    func configureInfoMovieStackView() {
        let countriesString: String
        let genresString = movieGenres.joined()
        
        if let countries = movieDetails?.originCountry {
            countriesString = countries.joined(separator: ",")
        } else {
            countriesString = "N/A"
        }
    
        
        infoMovieStack.translatesAutoresizingMaskIntoConstraints = false
        infoMovieStack.alignment = .leading
        infoMovieStack.spacing = 10
        infoMovieStack.axis = .vertical

        let movieTitle: UILabel = {
            let label = UILabel()
            label.text = model!.originalTitle
            label.font = UIFont(name: "Montserrat-SemiBold", size: 30)
            label.textColor = .white
            return label
        }()
        
        let releaseDateLabel: UILabel = {
            let label = UILabel()
            label.text = "\(model!.releaseDate)•\(genresString)"
            label.font = UIFont(name: "Montserrat-SemiBold", size: 13)
            label.textColor = .gray
            return label
        }()
        
        let countryLabel: UILabel = {
            let label = UILabel()
            label.text = "Country: \(countriesString)"
            label.font = UIFont(name: "Montserrat-SemiBold", size: 13)
            label.textColor = .gray
            return label
        }()
        
        let languageLabel: UILabel = {
            let label = UILabel()
//            label.text = "Original language: \(movieDetails!.originalLanguage)"
            label.text = "Original language:"
            label.font = UIFont(name: "Montserrat-SemiBold", size: 13)
            label.textColor = .gray
            return label
        }()
        
        
        let statusLabel: UILabel = {
            let label = UILabel()
//            label.text = "Status: \(movieDetails!.status)"
            label.text = "Status: "
            label.font = UIFont(name: "Montserrat-SemiBold", size: 13)
            label.textColor = .gray
            return label
        }()
        
        
        
        

        infoMovieStack.addArrangedSubview(movieTitle)
        infoMovieStack.addArrangedSubview(releaseDateLabel)
        infoMovieStack.addArrangedSubview(countryLabel)
        infoMovieStack.addArrangedSubview(languageLabel)
        infoMovieStack.addArrangedSubview(statusLabel)
        view.addSubview(infoMovieStack)
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
            
            
            
            
            
            
//            Move all this constraints into its own view
            
            
            
//            mainMovieImage.topAnchor.constraint(equalTo: contentView.topAnchor),
//            mainMovieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            mainMovieImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            mainMovieImage.heightAnchor.constraint(equalToConstant: 550),
//            
//            hdLabel.bottomAnchor.constraint(equalTo: mainMovieImage.bottomAnchor, constant: -10),
//            hdLabel.leadingAnchor.constraint(equalTo: mainMovieImage.leadingAnchor, constant: 10),
//            hdLabel.widthAnchor.constraint(equalToConstant: 30),
//            hdLabel.heightAnchor.constraint(equalToConstant: 25),
//            
//            qualityLabel.bottomAnchor.constraint(equalTo: hdLabel.bottomAnchor),
//            qualityLabel.leadingAnchor.constraint(equalTo: hdLabel.trailingAnchor, constant: 5),
//            qualityLabel.widthAnchor.constraint(equalToConstant: 30),
//            qualityLabel.heightAnchor.constraint(equalToConstant: 25),
//            
//            genresStackView.bottomAnchor.constraint(equalTo: hdLabel.bottomAnchor),
//            genresStackView.trailingAnchor.constraint(equalTo: mainMovieImage.trailingAnchor, constant: -10),
//            genresStackView.heightAnchor.constraint(equalToConstant: 25),
//            
//            rankingLabel.topAnchor.constraint(equalTo: mainMovieImage.bottomAnchor, constant: 10),
//            rankingLabel.leadingAnchor.constraint(equalTo: hdLabel.leadingAnchor),
//            rankingLabel.widthAnchor.constraint(equalToConstant: 100),
//            rankingLabel.heightAnchor.constraint(equalToConstant: 35),
//            
//            iconsStack.topAnchor.constraint(equalTo: rankingLabel.topAnchor),
//            iconsStack.trailingAnchor.constraint(equalTo: genresStackView.trailingAnchor),
//            iconsStack.heightAnchor.constraint(equalToConstant: 35),
//            iconsStack.widthAnchor.constraint(equalToConstant: 110),
//            
//            infoMovieStack.topAnchor.constraint(equalTo: rankingLabel.bottomAnchor, constant: 20),
//            infoMovieStack.leadingAnchor.constraint(equalTo: rankingLabel.leadingAnchor),
//            infoMovieStack.trailingAnchor.constraint(equalTo: iconsStack.trailingAnchor)
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
