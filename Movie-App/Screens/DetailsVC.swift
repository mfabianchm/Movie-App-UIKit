//
//  DetailsVC.swift
//  Movie-App
//
//  Created by Marcos Chong on 11/06/24.
//

import UIKit

class DetailsVC: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let profileImage = UIImageView()
    let mainMovieImage = UIImageView()
    let hdLabel = UILabel()
    let qualityLabel = UILabel()
    let genresStackView = UIStackView()
    let rankingLabel = UILabel()
    let iconsStack = UIStackView()
    
    var posterImage: UIImage?
    
    var padding: CGFloat = 10
    
    let model: Movie?
    let genres: [Genre]?
    var movieGenresId: [Int]?

    init(model: Movie?, genres: [Genre]) {
        self.model = model
        self.genres = genres
        self.movieGenresId = model?.genreIds
        super.init(nibName: nil, bundle: nil)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage()
        print(model)
    }
    
//    override func viewWillAppear(_ animated: Bool){
//        super.viewWillAppear(animated)
//        self.navigationController?.isNavigationBarHidden = true
//    }
    
//    override func viewWillDisappear(_ animated: Bool){
//        super.viewWillDisappear(animated)
//        self.navigationController?.isNavigationBarHidden = false
//       }
    
    func configure() {
        configureScrollView()
        configureContentView()
        configureProfileImage()
        configureMainImage()
        configureGenresStackView()
        configureRankingLabel()
        configureIconsStackView()
        configureConstrainst()
    }
    
    func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(named: "Dark-Gray")
        view.addSubview(scrollView)
    }
    
    func configureContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = UIColor(named: "Dark-Gray")
        scrollView.addSubview(contentView)
    }
    
    func configureProfileImage() {
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.image = UIImage(named: "profile-image")
        profileImage.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        profileImage.layer.cornerRadius = 0.5 * profileImage.bounds.size.width
        profileImage.clipsToBounds = true
        profileImage.layer.zPosition = 100
        contentView.addSubview(profileImage)
    }
    
    func configureMainImage() {
        contentView.addSubview(mainMovieImage)
        
        mainMovieImage.addSubview(hdLabel)
        mainMovieImage.addSubview(qualityLabel)
        
        mainMovieImage.image = self.posterImage
        mainMovieImage.contentMode = .scaleToFill
        mainMovieImage.backgroundColor = .gray
        mainMovieImage.translatesAutoresizingMaskIntoConstraints = false
        
        hdLabel.translatesAutoresizingMaskIntoConstraints = false
        hdLabel.text = "HD"
        hdLabel.backgroundColor = UIColor(named: "Yellow")
        hdLabel.layer.cornerRadius = 5
        hdLabel.layer.masksToBounds = true
        hdLabel.font = UIFont(name: "Montserrat-Medium", size: 15)
        hdLabel.textAlignment = .center
        
        qualityLabel.translatesAutoresizingMaskIntoConstraints = false
        qualityLabel.text = "4K"
        qualityLabel.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        qualityLabel.textColor = .white
        qualityLabel.layer.cornerRadius = 5
        qualityLabel.layer.masksToBounds = true
        qualityLabel.font = UIFont(name: "Montserrat-Medium", size: 15)
        qualityLabel.textAlignment = .center
    }
    
    func configureGenresStackView() {
        
        if(movieGenresId!.count > 2) {
            let lastElement = movieGenresId!.count - 1
            movieGenresId!.removeSubrange(2...lastElement)
        }
        
        var movieGenres: [String] = []
        
        movieGenresId?.forEach { id in
            genres?.forEach { genre in
                if(genre.id) == id {
                    movieGenres.append(genre.name)
                }
            }
        }
    
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
    
    func configureConstrainst() {
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: 0
                                        ),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: 0),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 2000),
            
            profileImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            profileImage.widthAnchor.constraint(equalToConstant: 50),
            profileImage.heightAnchor.constraint(equalToConstant: 50),
            
            mainMovieImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainMovieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainMovieImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainMovieImage.heightAnchor.constraint(equalToConstant: 550),
            
            hdLabel.bottomAnchor.constraint(equalTo: mainMovieImage.bottomAnchor, constant: -10),
            hdLabel.leadingAnchor.constraint(equalTo: mainMovieImage.leadingAnchor, constant: 10),
            hdLabel.widthAnchor.constraint(equalToConstant: 30),
            hdLabel.heightAnchor.constraint(equalToConstant: 25),
            
            qualityLabel.bottomAnchor.constraint(equalTo: hdLabel.bottomAnchor),
            qualityLabel.leadingAnchor.constraint(equalTo: hdLabel.trailingAnchor, constant: 5),
            qualityLabel.widthAnchor.constraint(equalToConstant: 30),
            qualityLabel.heightAnchor.constraint(equalToConstant: 25),
            
            genresStackView.bottomAnchor.constraint(equalTo: hdLabel.bottomAnchor),
            genresStackView.trailingAnchor.constraint(equalTo: mainMovieImage.trailingAnchor, constant: -10),
            genresStackView.heightAnchor.constraint(equalToConstant: 25),
            
            rankingLabel.topAnchor.constraint(equalTo: mainMovieImage.bottomAnchor, constant: 10),
            rankingLabel.leadingAnchor.constraint(equalTo: hdLabel.leadingAnchor),
            rankingLabel.widthAnchor.constraint(equalToConstant: 100),
            rankingLabel.heightAnchor.constraint(equalToConstant: 35),
            
            iconsStack.topAnchor.constraint(equalTo: rankingLabel.topAnchor),
            iconsStack.trailingAnchor.constraint(equalTo: genresStackView.trailingAnchor),
            iconsStack.heightAnchor.constraint(equalToConstant: 35),
            iconsStack.widthAnchor.constraint(equalToConstant: 110),
        ])
    }
    
    
    
    func getImage() {
        guard let movieData = model else {return}
        guard let movieUrl = movieData.posterPath else {return}
        let url = URL(string: "https://image.tmdb.org/t/p/original\(movieUrl)")!
        downloadImage(from: url)
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.mainMovieImage.image = UIImage(data: data)
            }
        }
    }

}
