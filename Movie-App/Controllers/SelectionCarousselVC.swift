//
//  SelectionCarousselVC.swift
//  Movie-App
//
//  Created by Marcos Chong on 31/05/24.
//

import UIKit

class SelectionCarousselVC: UIViewController {
    
    let buttonsText: [String] = ["Popular", "New", "Premieres", "Random"]
    let buttonsStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        configure()
    }
    
    func configure() {
        configureStack()
        configureButtons()
        configureConstrainst()
    }
    
    func configureStack() {
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.axis = .horizontal
        buttonsStackView.distribution = .equalSpacing
        view.addSubview(buttonsStackView)
    }
    
    func configureButtons() {
        buttonsText.indices.forEach { index in
            let button = UIButton()
            button.setTitle(buttonsText[index], for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.setTitleColor(UIColor(named: "Yellow"), for: .selected)
            
            
            
            if(index == 0) {
                button.isSelected = true
                button.underlineText()
            }
            
            buttonsStackView.addArrangedSubview(button)
        }
    }
    
    func configureConstrainst() {
        NSLayoutConstraint.activate([
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    

  

}
