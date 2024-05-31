//
//  NavigationVC.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 24/05/24.
//

import UIKit

protocol NavigationDelegate{
    func navigation(didSelect: NavigationModel?)
}

enum NavigationTypes{
    case home,search, favorites
}

struct NavigationModel {
    let name: String
    let type: NavigationTypes
}

class NavigationVC: UIViewController{

    var myView: NavigationView {return view as! NavigationView}
    unowned var collectionView: UICollectionView {return myView.collectionView}
    var delegate: NavigationDelegate?
    var list = [NavigationModel]()

    override func loadView() {
        view = NavigationView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupList()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func setupList(){
        list.append(NavigationModel(name: "Home", type: .home))
        list.append(NavigationModel(name: "Search", type: .search))
        list.append(NavigationModel(name: "Favorites", type: .favorites))
    }
}


extension NavigationVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NavigationCell", for: indexPath) as! NavigationCell
        let model = list[indexPath.item]
        cell.label.text = model.name
        return cell
    }
}

extension NavigationVC: UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = list[indexPath.row]
        let vcName = model.name
        
        delegate?.navigation(didSelect: list[indexPath.item])
    }
}

extension NavigationVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 45)
    }
}
