//
//  LoadingViewController.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 18/06/24.
//

import UIKit

class LoadingViewController: UIViewController {
    
  
    let spinner: UIActivityIndicatorView = LoadingView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        view.isUserInteractionEnabled = false
//        view.backgroundColor = UIColor(named: "Medium-Gray")
        view.backgroundColor = .red
        spinner.startAnimating()
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100)
        ])
        
    }
    

   

}
