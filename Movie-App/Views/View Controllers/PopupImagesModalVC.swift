//
//  PopupImagesModalVC.swift
//  Movie-App
//
//  Created by Marcos Chong on 02/07/24.
//

import UIKit

class PopupImagesModalVC: UIViewController {
    
    let images: [UIImage]?
    let imageView = UIImageView()
    
    var imageToShow: UIImage?
    var currentIndex: Int?
    
    let nextButton = UIButton()
    let prevButton = UIButton()
    let closeButton = UIButton()

    init(images: [UIImage]?, imageToShow: UIImage) {
        self.images = images
        self.imageToShow = imageToShow
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentIndex()
        configure()
    }
    
    func configure() {
        view.backgroundColor = .black
        configureImageView()
        configureButtons()
    }
    
    func configureImageView() {
        view.addSubview(imageView)
        
        imageView.image = imageToShow
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 280),
            imageView.widthAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    func getCurrentIndex() {
        let currentIndex = images!.firstIndex{$0 === imageToShow!}
        self.currentIndex = currentIndex
    }
    
    func configureButtons() {
        view.addSubview(prevButton)
        view.addSubview(nextButton)
        view.addSubview(closeButton)
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)
        let prevArrowImage = UIImage(systemName: "arrow.left.circle.fill", withConfiguration: largeConfig)
        let nextArrowImage = UIImage(systemName: "arrow.right.circle.fill", withConfiguration: largeConfig)
        let closeImage = UIImage(systemName: "arrow.backward.circle", withConfiguration: largeConfig)
        
        prevButton.setImage(prevArrowImage, for: .normal)
        prevButton.imageView?.contentMode = .scaleAspectFit
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        prevButton.addTarget(self, action: #selector(showPrevImage), for: .touchUpInside)
        
        nextButton.setImage(nextArrowImage, for: .normal)
        nextButton.imageView?.contentMode = .scaleAspectFit
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(showNextImage), for: .touchUpInside)
        
        closeButton.setImage(closeImage, for: .normal)
        closeButton.imageView?.contentMode = .scaleAspectFit
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            
            prevButton.widthAnchor.constraint(equalToConstant: 40),
            prevButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            prevButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            prevButton.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -5),
            
            nextButton.widthAnchor.constraint(equalToConstant: 40),
            nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            nextButton.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5)
        ])
    }
    
    @objc func showNextImage() {
        
        currentIndex = currentIndex! + 1

        if(currentIndex! == images?.count) {
            currentIndex = 0
            imageToShow = images![currentIndex!]
        } else {
            imageToShow = images![currentIndex!]
        }
        
        let nextImage = imageToShow
        
        DispatchQueue.main.async {
            self.imageView.image = nextImage
        }
    }
    
    @objc func showPrevImage() {
        
        currentIndex = currentIndex! - 1
        
        if(currentIndex! < 0) {
            currentIndex = images!.count - 1
            imageToShow = images![currentIndex!]
        } else {
            imageToShow = images![currentIndex!]
        }
        
        let nextImage = imageToShow
        
        DispatchQueue.main.async {
            self.imageView.image = nextImage
        }
    }
    
    @objc func closeModal() {
        self.dismiss(animated: true)
    }
    
}
