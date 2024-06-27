//
//  DetailsContentView.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 20/06/24.
//

import UIKit

class DetailsContentView: UIView {
    
    let profileImage = ProfileImageView(frame: .zero)
    var mainMovieImage: DetailsPosterImage?
    let rankingLabel = UILabel()
    let iconsStack = IconsStackView()
    var infoMovieStack:  InfoMovieStackView?
    
    
    let storyLineView = StoryLineView()
    
    var castCarousel: UIView?
    var movieImagesCarousel: UIView?
    
    var padding: CGFloat = 10
    
    var posterImage: UIImage?
    
    let model: Movie?
    let genres: [String]?
    let movieDetails: MovieDetails?
    let images: [UIImage]?
    let cast: Cast?

    init(model: Movie, genres: [String], details: MovieDetails, images: [UIImage], cast: Cast) {
        self.model = model
        self.genres = genres
        self.movieDetails = details
        self.images = images
        self.cast = cast
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(named: "Dark-Gray")
        
        mainMovieImage = DetailsPosterImage(posterImage: images![0], movieGenres: genres!)
        infoMovieStack = InfoMovieStackView(title: model!.title, releaseDate: model!.releaseDate, language: movieDetails!.originalLanguage, country: movieDetails!.originCountry, status: movieDetails!.status, genres: genres!.joined())
        
        
        addViews()
        configureRankingLabel()
        configureLayout()
        
        
        profileImage.layer.zPosition = 100

    }
    
    
    func configureRankingLabel() {
        rankingLabel.translatesAutoresizingMaskIntoConstraints = false
        rankingLabel.backgroundColor = UIColor(named: "Yellow")
        rankingLabel.textColor = .gray
        rankingLabel.layer.cornerRadius = 5
        rankingLabel.layer.masksToBounds = true
        rankingLabel.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        rankingLabel.textAlignment = .center
        
        guard let model = model else {
            rankingLabel.text = "N/A"
            return
        }
        
        let ranking = String(format: "%.2f", model.voteAverage)
        
        let attributedString = NSMutableAttributedString(string: "IMDB \(ranking)/10")
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: 10))
        rankingLabel.attributedText = attributedString
    }
    
    func addViews() {
        self.addSubview(profileImage)
        self.addSubview(mainMovieImage!)
        self.addSubview(rankingLabel)
        self.addSubview(iconsStack)
        self.addSubview(infoMovieStack!)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            profileImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: -45),
            profileImage.widthAnchor.constraint(equalToConstant: 50),
            profileImage.heightAnchor.constraint(equalToConstant: 50),
            
            mainMovieImage!.topAnchor.constraint(equalTo: self.topAnchor),
            mainMovieImage!.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainMovieImage!.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainMovieImage!.heightAnchor.constraint(equalToConstant: 550),
            
            rankingLabel.topAnchor.constraint(equalTo: mainMovieImage!.bottomAnchor, constant: 10),
            rankingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            rankingLabel.widthAnchor.constraint(equalToConstant: 100),
            rankingLabel.heightAnchor.constraint(equalToConstant: 35),
            
            iconsStack.topAnchor.constraint(equalTo: rankingLabel.topAnchor),
            iconsStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            iconsStack.heightAnchor.constraint(equalToConstant: 35),
            iconsStack.widthAnchor.constraint(equalToConstant: 110),
            
            infoMovieStack!.topAnchor.constraint(equalTo: rankingLabel.bottomAnchor, constant: 20),
            infoMovieStack!.leadingAnchor.constraint(equalTo: rankingLabel.leadingAnchor),
            infoMovieStack!.trailingAnchor.constraint(equalTo: iconsStack.trailingAnchor)
        ])
        
    }
    
    func configureCastCarouselView(childView: UIView) {
        
        self.castCarousel = childView
        
        self.addSubview(castCarousel!)
        self.addSubview(storyLineView)
        storyLineView.updateView(description: model!.overview ?? "N/A")
        
        NSLayoutConstraint.activate([
            castCarousel!.topAnchor.constraint(equalTo: infoMovieStack!.bottomAnchor, constant: 10),
            castCarousel!.leadingAnchor.constraint(equalTo: infoMovieStack!.leadingAnchor),
            castCarousel!.trailingAnchor.constraint(equalTo: infoMovieStack!.trailingAnchor),
            castCarousel!.heightAnchor.constraint(equalToConstant: 140),
            
            storyLineView.topAnchor.constraint(equalTo: castCarousel!.bottomAnchor, constant: 10),
            storyLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            storyLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding)
            
            
        ])
    }
    
    func configureMoviesCarouselView(childView: UIView) {
        
        self.movieImagesCarousel = childView
        
        self.addSubview(movieImagesCarousel!)
        self.addSubview(storyLineView)
        storyLineView.updateView(description: model!.overview ?? "N/A")
        
        NSLayoutConstraint.activate([
            castCarousel!.topAnchor.constraint(equalTo: infoMovieStack!.bottomAnchor, constant: 10),
            castCarousel!.leadingAnchor.constraint(equalTo: infoMovieStack!.leadingAnchor),
            castCarousel!.trailingAnchor.constraint(equalTo: infoMovieStack!.trailingAnchor),
            castCarousel!.heightAnchor.constraint(equalToConstant: 140),
            
            storyLineView.topAnchor.constraint(equalTo: castCarousel!.bottomAnchor, constant: 10),
            storyLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            storyLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding)
            
            
        ])
    }

}

