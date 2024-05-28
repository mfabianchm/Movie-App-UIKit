//
//  NavigationCell.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 24/05/24.
//

import UIKit

class NavigationCell: UICollectionViewCell {
    override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }

        func commonInit(){
            [label,divider].forEach{contentView.addSubview($0)}
            setConstraints()
        }

        func setConstraints() {
            let constraints = [
                label.centerYAnchor.constraint(equalTo: centerYAnchor),
                label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

                divider.leadingAnchor.constraint(equalTo: leadingAnchor),
                divider.bottomAnchor.constraint(equalTo: bottomAnchor),
                divider.trailingAnchor.constraint(equalTo: trailingAnchor),
                divider.heightAnchor.constraint(equalToConstant: 1)
            ]
            NSLayoutConstraint.activate(constraints)
        }

        public let label: UILabel = {
            let v = UILabel()
            v.text = "Label Text"
            v.textColor = .white
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
        }()

        public let divider: UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.backgroundColor = UIColor(named: "Medium-Gray")
            return v
        }()
}
