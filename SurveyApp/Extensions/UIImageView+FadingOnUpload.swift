//
//  UIImageView+FadingOnUpload.swift
//  SurveyApp
//
//  Created by Aleksey on 29.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import Foundation

import UIKit
import SDWebImage

extension UIImageView {
  
  public func setImageFaded(with url: URL!, completion: ((Void) -> Void)? = nil) {
    self.sd_setImage(with: url) { (image, error, cacheType, url) in
      completion?()
      guard image != nil, cacheType == .none else { return }
      UIView.transition(
        with: self,
        duration: 0.3,
        options: UIViewAnimationOptions.transitionCrossDissolve,
        animations: nil,
        completion: nil
      )
    }
  }
}
