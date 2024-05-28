//
//  SideBar.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 24/05/24.
//

import UIKit
protocol SidebarDelegate {
    func sidebarDidOpen()
    func sidebarDidClose(with item: NavigationModel?)
}

class SidebarLauncher: NSObject{
//    func navigation(didSelect: NavigationModel?) {
//        print("navigation")
//    }
    

    var view: UIView?
    var delegate: SidebarDelegate?
    var vc: NavigationVC?
    
    init(delegate: SidebarDelegate) {
        super.init()
        self.delegate = delegate
    }

    public let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "clear"), for: .normal)
        button.tintColor = .white
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    func show(){
        let bounds = UIScreen.main.bounds
        let v = UIView(frame: CGRect(x: -bounds.width, y: 0, width: bounds.width, height: bounds.height))
        v.backgroundColor = .clear
        let vc = NavigationVC()
        vc.delegate = self
        v.addSubview(vc.view)
        v.addSubview(closeButton)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([

            closeButton.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 10),
            closeButton.topAnchor.constraint(equalTo: v.topAnchor, constant: 80),
            closeButton.widthAnchor.constraint(equalToConstant: 50),
            closeButton.heightAnchor.constraint(equalToConstant: 50),

            vc.view.topAnchor.constraint(equalTo: closeButton.bottomAnchor,constant: 20),
            vc.view.leadingAnchor.constraint(equalTo: v.leadingAnchor),
            vc.view.bottomAnchor.constraint(equalTo: v.bottomAnchor),
            vc.view.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: 0)
            ])

        closeButton.addTarget(self, action: #selector(close(_:)), for: .touchUpInside)
        
        self.view = v
        self.vc = vc
        UIApplication.shared.keyWindow?.addSubview(v)

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
            self.view?.frame = CGRect(x: 0, y: 0, width: self.view!.frame.width, height: self.view!.frame.height)
            self.view?.backgroundColor = UIColor(named: "Dark-Gray")
        }, completion: {completed in
            self.delegate?.sidebarDidOpen()
        })

    }

    @objc func close(_ sender: UIButton){
        closeSidebar(option: nil)
    }
    
    func closeSidebar(option: NavigationModel?){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
            if let view = self.view{
                view.frame = CGRect(x: -view.frame.width, y: 0, width: view.frame.width, height: view.frame.height)
                self.view?.backgroundColor = .clear

            }
        }, completion: {completed in
            self.view?.removeFromSuperview()
            self.view = nil
            self.vc = nil
            self.delegate?.sidebarDidClose(with: option)
        })
    }

}
extension SidebarLauncher: NavigationDelegate{
    func navigation(didSelect: NavigationModel?) {
        closeSidebar(option: didSelect)
    }
}
