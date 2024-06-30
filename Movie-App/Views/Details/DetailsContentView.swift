//
//  DetailsContentView.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 20/06/24.
//

import UIKit

class DetailsContentView: UIView {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let profileImage = ProfileImageView(frame: .zero)
    let rankingLabel = UILabel()
    let mainMovieImage = DetailsPosterImage()
    let iconsStack = IconsStackView()
    let infoMovieStack = InfoMovieStackView()
    let storylineView = StoryLineView()
    
    
    var castCarouselView: UIView?
    var movieImagesCarousel: UIView?
    
    var padding: CGFloat = 10
    var posterImage: UIImage?
    
    var model: Movie?
    var genres: [String]?
    var movieDetails: MovieDetails?
    var images: [UIImage]?
    var cast: Cast?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        configureMainView()
        configureProfileImage()
        configureMainMovieImage()
        configureRankingLabel()
        configureIconsStack()
        configureInfoMovieStack()
        configureStorylineView()
        configureConstrainst()
    }
    
    func configureMainView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = UIColor(named: "Dark-Gray")
    }
    
    func configureRankingLabel() {
        contentView.addSubview(rankingLabel)
        rankingLabel.translatesAutoresizingMaskIntoConstraints = false
        rankingLabel.backgroundColor = UIColor(named: "Yellow")
        rankingLabel.textColor = .gray
        rankingLabel.layer.cornerRadius = 5
        rankingLabel.layer.masksToBounds = true
        rankingLabel.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        rankingLabel.textAlignment = .center
        rankingLabel.text = "N/A"
    }
    
    func configureProfileImage() {
        contentView.addSubview(profileImage)
        profileImage.layer.zPosition = 100
    }
    
    func configureMainMovieImage() {
        contentView.addSubview(mainMovieImage)
    }
    
    func configureIconsStack() {
        contentView.addSubview(iconsStack)
    }
    
    func configureInfoMovieStack() {
        contentView.addSubview(infoMovieStack)
    }
    
    func configureStorylineView() {
        contentView.addSubview(storylineView)
    }
    
    
    func configureConstrainst() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: 0),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: 0),
            contentView.widthAnchor.constraint(equalTo: self.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 2000),
            
            profileImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -45),
            profileImage.widthAnchor.constraint(equalToConstant: 50),
            profileImage.heightAnchor.constraint(equalToConstant: 50),
            
            mainMovieImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainMovieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainMovieImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainMovieImage.heightAnchor.constraint(equalToConstant: 550),
            
            rankingLabel.topAnchor.constraint(equalTo: mainMovieImage.bottomAnchor, constant: 10),
            rankingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            rankingLabel.widthAnchor.constraint(equalToConstant: 100),
            rankingLabel.heightAnchor.constraint(equalToConstant: 35),
            
            iconsStack.topAnchor.constraint(equalTo: rankingLabel.topAnchor),
            iconsStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            iconsStack.heightAnchor.constraint(equalToConstant: 35),
            iconsStack.widthAnchor.constraint(equalToConstant: 110),
            
            infoMovieStack.topAnchor.constraint(equalTo: rankingLabel.bottomAnchor, constant: 20),
            infoMovieStack.leadingAnchor.constraint(equalTo: rankingLabel.leadingAnchor),
            infoMovieStack.trailingAnchor.constraint(equalTo: iconsStack.trailingAnchor),
        ])
    }
    
    func configureVCChildsContrains(carouselView: UIView, movieImagesView: UIView) {
        self.castCarouselView = carouselView
        self.movieImagesCarousel = movieImagesView
        
        NSLayoutConstraint.activate([
            castCarouselView!.topAnchor.constraint(equalTo: infoMovieStack.bottomAnchor, constant: 10),
            castCarouselView!.leadingAnchor.constraint(equalTo: infoMovieStack.leadingAnchor),
            castCarouselView!.trailingAnchor.constraint(equalTo: infoMovieStack.trailingAnchor),
            castCarouselView!.heightAnchor.constraint(equalToConstant: 140),
            
            storylineView.topAnchor.constraint(equalTo: castCarouselView!.bottomAnchor, constant: 10),
            storylineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            storylineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            movieImagesCarousel!.topAnchor.constraint(equalTo: storylineView.bottomAnchor, constant: 10),
            movieImagesCarousel!.leadingAnchor.constraint(equalTo: infoMovieStack.leadingAnchor),
            movieImagesCarousel!.trailingAnchor.constraint(equalTo: infoMovieStack.trailingAnchor),
            movieImagesCarousel!.heightAnchor.constraint(equalToConstant: 140),
        ])
    }
    
    func updateUI(model: Movie, genres: [String], movieDetails: MovieDetails, movieImages: [UIImage], movieCast: Cast) {
        mainMovieImage.updateImageView(image: movieImages[0], genres: genres)
        updateRankingLabel(model: model)
        infoMovieStack.updateInfoStackView(title: model.originalTitle ,language: movieDetails.originalLanguage, country: movieDetails.originCountry, status: movieDetails.status, genres: genres, releaseDate: movieDetails.releaseDate)
        storylineView.updateView(description: model.overview ?? "N/A")
        
        
    }
    
    func updateRankingLabel(model: Movie) {
        let ranking = String(format: "%.2f", model.voteAverage)
        
        let attributedString = NSMutableAttributedString(string: "IMDB \(ranking)/10")
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: 10))
        rankingLabel.attributedText = attributedString
    }
    
}
