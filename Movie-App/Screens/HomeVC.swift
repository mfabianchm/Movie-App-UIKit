//
//  HomeVC.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 23/05/24.
//

import UIKit

class HomeVC: UIViewController {

    let openSideBarBtn = UIButton()
    let logoImage = UIImageView()
    let appNameLabel = UILabel()
    let profileImage = UIImageView()
    
    var padding: CGFloat = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Dark-Gray")
        configure()
    }
    
    func configure() {
        configureSideBarBtn()
        configureUIImageView()
        configureAppNameLabel()
        configureProfileImage()
        configureConstrainst()
    }
    
    func configureSideBarBtn() {
        openSideBarBtn.translatesAutoresizingMaskIntoConstraints = false
        openSideBarBtn.setImage(UIImage(systemName: "list.dash"), for: .normal)
        openSideBarBtn.tintColor = .white
        openSideBarBtn.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        openSideBarBtn.layer.cornerRadius = 0.5 * openSideBarBtn.bounds.size.width
        openSideBarBtn.clipsToBounds = true
        openSideBarBtn.layer.borderColor = UIColor(named: "Medium-Gray")?.cgColor
        openSideBarBtn.layer.borderWidth = 1
        view.addSubview(openSideBarBtn)
    }
    
    func configureUIImageView() {
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.image = UIImage(systemName: "movieclapper")
        logoImage.tintColor = UIColor(named: "Yellow")
        view.addSubview(logoImage)
    }
    
    func configureAppNameLabel() {
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        appNameLabel.text = "Movie Online"
        appNameLabel.font = .systemFont(ofSize: 20)
        appNameLabel.textColor = .white
        view.addSubview(appNameLabel)
    }
    
    func configureProfileImage() {
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.image = UIImage(named: "profile-image")
        profileImage.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        profileImage.layer.cornerRadius = 0.5 * profileImage.bounds.size.width
        profileImage.clipsToBounds = true
        view.addSubview(profileImage)
    }
    
    func configureConstrainst() {
        NSLayoutConstraint.activate([
            openSideBarBtn.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            openSideBarBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            openSideBarBtn.widthAnchor.constraint(equalToConstant: 50),
            openSideBarBtn.heightAnchor.constraint(equalToConstant: 50),
            
            logoImage.leadingAnchor.constraint(equalTo: openSideBarBtn.trailingAnchor, constant: 40),
            logoImage.topAnchor.constraint(equalTo: openSideBarBtn.topAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 50),
            logoImage.heightAnchor.constraint(equalToConstant: 50),
            
            appNameLabel.topAnchor.constraint(equalTo: logoImage.topAnchor),
            appNameLabel.bottomAnchor.constraint(equalTo: logoImage.bottomAnchor),
            appNameLabel.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: padding),
            
            profileImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            profileImage.topAnchor.constraint(equalTo: openSideBarBtn.topAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 50),
            profileImage.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
}


