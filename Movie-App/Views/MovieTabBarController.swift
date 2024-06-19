//
//  MovieTabBarController.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 23/05/24.
//

import UIKit

class MovieTabBarController: UITabBarController {
    
    var homeNC: UIViewController?
    var favoritesNC: UIViewController?
    var searchNC: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = UIColor(named: "Yellow")
        UITabBar.appearance().barTintColor = UIColor(named: "Medium-Gray")
        UITabBar.appearance().isTranslucent = false
        homeNC = createHomeNC()
        favoritesNC = createFavoritesNC()
        searchNC = createSearchNC()
        viewControllers = [homeNC!, searchNC!, favoritesNC!]
    }
    
    func createHomeNC() -> UINavigationController {
        let homeVC        = HomeVC()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "homekit"), tag: 0)
        homeVC.contentView.openSideBarBtn.addTarget(self, action: #selector(didSelect(_:)), for: .touchUpInside)
        
        return UINavigationController(rootViewController: homeVC)
    }
    
    func createSearchNC() -> UINavigationController {
        let searchVC        = SearchVC()
        searchVC.title      = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    
    func createFavoritesNC() -> UINavigationController {
        let favoritesListVC         = FavoritesVC()
        favoritesListVC.title       = "Favorites"
        favoritesListVC.tabBarItem  = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        
        return UINavigationController(rootViewController: favoritesListVC)
    }
    
    @objc func didSelect(_ sender: UIButton){
            SidebarLauncher.init(delegate: self).show()
    }
    
}

extension MovieTabBarController: SidebarDelegate{
    func sidebarDidOpen() {
        print("sideBar opened")
    }
    
    func sidebarDidClose(with item: NavigationModel?) {
        guard let item = item else {return}
        switch item.type {
        case .home:
            selectedViewController = homeNC
        case .favorites:
            selectedViewController = favoritesNC
        case .search:
            selectedViewController = searchNC
        }
    }
}
