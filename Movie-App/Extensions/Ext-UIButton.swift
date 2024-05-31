//
//  Ext-UIButton.swift
//  Movie-App
//
//  Created by Marcos Chong on 31/05/24.
//

import UIKit

extension UIButton {
  func underlineText() {
    guard let title = title(for: .normal) else { return }

    let titleString = NSMutableAttributedString(string: title)
    titleString.addAttribute(
      .underlineStyle,
      value: NSUnderlineStyle.single.rawValue,
      range: NSRange(location: 0, length: title.count)
    )
    setAttributedTitle(titleString, for: .normal)
  }
}
