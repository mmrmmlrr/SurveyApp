//
//  UIColor+Creation.swift
//  Reel
//
//  Created by Aleksey on 15.10.16.
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit

extension UIColor {
  
  static func rgb(_ red: Int, _ green: Int, _ blue: Int) -> UIColor {
    return UIColor(
      red: CGFloat(red) / 255.0,
      green: CGFloat(green) / 255.0,
      blue: CGFloat(blue) / 255.0,
      alpha: 1.0
    )
  }
  
}
