//
//  HomeContentView.swift
//  Movie-App
//
//  Created by Marcos Chong on 18/06/24.
//

import UIKit

class HomeContentView: UIView {
    
    let openSideBarBtn = SideBarButton()
    let logoView = AppLogoView()
    let profileImage = ProfileImageView(frame: .zero)
    let searchBar = SearchBarView()
    
    var padding: CGFloat = 10

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(named: "Dark-Gray")
        
        self.addSubview(openSideBarBtn)
        self.addSubview(logoView)
        self.addSubview(profileImage)
        self.addSubview(searchBar)
        
        configureLayout()
    }
    
    
    func configureLayout() {
        NSLayoutConstraint.activate([
           
            openSideBarBtn.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            openSideBarBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            openSideBarBtn.widthAnchor.constraint(equalToConstant: 50),
            openSideBarBtn.heightAnchor.constraint(equalToConstant: 50),
            
            logoView.leadingAnchor.constraint(equalTo: openSideBarBtn.trailingAnchor, constant: 10),
            logoView.topAnchor.constraint(equalTo: openSideBarBtn.topAnchor),
            logoView.bottomAnchor.constraint(equalTo: openSideBarBtn.bottomAnchor),
           
            profileImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            profileImage.topAnchor.constraint(equalTo: openSideBarBtn.topAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 50),
            profileImage.heightAnchor.constraint(equalToConstant: 50),
            
            searchBar.topAnchor.constraint(equalTo: openSideBarBtn.bottomAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 65),
            
        ])
    }
    
   

}
