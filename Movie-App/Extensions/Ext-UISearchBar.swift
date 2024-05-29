//
//  Ext-UISearchBar.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 29/05/24.
//

import UIKit

extension UISearchBar {
    func setIconColor(_ color: UIColor) {
            for subView in self.subviews {
                for subSubView in subView.subviews {
                    let view = subSubView as? UITextInputTraits
                    if view != nil {
                        let textField = view as? UITextField
                        let glassIconView = textField?.leftView as? UIImageView
                        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
                        glassIconView?.tintColor = color
                        break
                    }
                }
            }
        }
}
