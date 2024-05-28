//
//  HomeVC.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 23/05/24.
//

import UIKit

class HomeVC: UIViewController {
    
    let openSideBarBtn = UIButton()
    
    var padding: CGFloat = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Dark-Gray")
        configure()
    }
    
    func configure() {
        configureSideBarBtn()
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
        openSideBarBtn.addTarget(self, action: #selector(didSelect(_:)), for: .touchUpInside)
        view.addSubview(openSideBarBtn)
    }
    
    func configureConstrainst() {
        NSLayoutConstraint.activate([
            openSideBarBtn.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            openSideBarBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            openSideBarBtn.widthAnchor.constraint(equalToConstant: 50),
            openSideBarBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    @objc func didSelect(_ sender: UIButton){
            SidebarLauncher.init(delegate: self).show()
        }
}


extension HomeVC: SidebarDelegate{
    func sidebarDidOpen() {
        print("sideBar opened")
    }

//    func sidebarDidClose(with item: NavigationModel?) {
//        guard let item = item else {return}
//        switch item.type {
//        case .home:
//            print("called home")
//        case .star:
//            print("called star")
//        case .about:
//            print("called about")
//        case .facebook:
//            print("called facebook")
//        case .instagram:
//            print("instagram")
//        }
//    }
}
