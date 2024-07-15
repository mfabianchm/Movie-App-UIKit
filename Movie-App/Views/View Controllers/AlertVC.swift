//
//  AlertVCViewController.swift
//  Movie-App
//
//  Created by Marcos Chong on 10/07/24.
//

import UIKit

class AlertVC: UIViewController {

    let containerView   = AlertView()
    let titleLabel = UILabel()
    let messageLabel = UILabel()
    let actionButton = UIButton()
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle     = title
        self.message        = message
        self.buttonTitle    = buttonTitle
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubview(containerView)
        view.addSubview(titleLabel)
        view.addSubview(actionButton)
        view.addSubview(messageLabel)
        
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }
    
    
    func configureContainerView() {
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    
    func configureTitleLabel() {
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor                   = .label
        titleLabel.adjustsFontSizeToFitWidth   = true
        titleLabel.minimumScaleFactor          = 0.9
        titleLabel.lineBreakMode               = .byTruncatingTail
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    
    func configureActionButton() {
        actionButton.configuration?.baseBackgroundColor = .systemBlue
        actionButton.configuration?.baseForegroundColor = .systemBlue
        actionButton.configuration?.title = title
        actionButton.configuration = .tinted()
        actionButton.configuration?.cornerStyle = .medium
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        actionButton.configuration?.image = UIImage(systemName: "checkmark.circle")
        actionButton.configuration?.imagePadding = 6
        actionButton.configuration?.imagePlacement = .leading
        
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    func configureMessageLabel() {
        messageLabel.text           = message ?? "Unable to complete request"
        messageLabel.numberOfLines  = 4
        
        messageLabel.textAlignment = .center
        messageLabel.textColor                           = .secondaryLabel
        messageLabel.font                                = UIFont.preferredFont(forTextStyle: .body)
        messageLabel.adjustsFontForContentSizeCategory   = true
        messageLabel.adjustsFontSizeToFitWidth           = true
        messageLabel.minimumScaleFactor                  = 0.75
        messageLabel.lineBreakMode                       = .byWordWrapping
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }

}
