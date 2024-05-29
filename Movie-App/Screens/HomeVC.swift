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
    let searchBar = UISearchBar()
    
    var padding: CGFloat = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Dark-Gray")
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//       searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Enter Search Here", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white

        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = UIColor(named: "Yellow")
        
        
    }
    
    func configure() {
        configureSideBarBtn()
        configureUIImageView()
        configureAppNameLabel()
        configureProfileImage()
        configureSearchBar()
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
            
            searchBar.topAnchor.constraint(equalTo: openSideBarBtn.bottomAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 65),
        ])
    }
    
    func configureSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        searchBar.barTintColor = UIColor(named: "Medium-Gray")
        searchBar.searchTextField.backgroundColor = UIColor(named: "Medium-Gray")
        searchBar.layer.cornerRadius = 20
        searchBar.clipsToBounds = true
        searchBar.searchTextField.leftView?.tintColor = UIColor(named: "Yellow")
        view.addSubview(searchBar)
    }
    
    
    
}


