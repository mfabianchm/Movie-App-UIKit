//
//  HomeVC.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 23/05/24.
//

import UIKit

class HomeVC: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = HomeContentView()
    
    let selectionCarouselVC = SelectionCarousselVC()
    
    var padding: CGFloat = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Dark-Gray")
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let textFieldInsideSearchBar = contentView.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white

        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = UIColor(named: "Yellow")
        
        
    }
    
    func configure() {
        view.addSubview(scrollView)
        configureScrollView()
        configureSearchBarDelegate()
        addVCChilds()
        configureConstrainst()
    }
    
    
    func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(named: "Dark-Gray")
        scrollView.addSubview(contentView)
    }
    
    func configureSearchBarDelegate() {
        contentView.searchBar.searchTextField.delegate = self
    }
    
    
    func addVCChilds() {
        self.add(selectionCarouselVC)
    }
    
    func configureConstrainst() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: 0),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: 0),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 2000),
            
            selectionCarouselVC.view.topAnchor.constraint(equalTo: contentView.searchBar.bottomAnchor, constant: 10),
            selectionCarouselVC.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            selectionCarouselVC.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            selectionCarouselVC.view.heightAnchor.constraint(equalToConstant: 400)
            
        ])
    }
}



extension HomeVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return button pressed")
        return true
    }
}


