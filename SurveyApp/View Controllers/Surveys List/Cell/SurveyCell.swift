//
//  SurveyCell.swift
//  SurveyApp
//
//  Created by Aleksey on 28.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import UIKit
import SDWebImage
import HandyText

class SurveyCell: UICollectionViewCell, ObjectConsuming {
  
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var descriptionLabel: UILabel!
  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
  
  func applyObject(_ object: Survey) {
    let headerStyle = TextStyle.based(on: .largeHeader).withLineBreakMode(.byWordWrapping).withAlignment(.center)
    let captionStyle = TextStyle.based(on: .smallCaption).withLineBreakMode(.byWordWrapping).withAlignment(.center)
    titleLabel.attributedText = object.hotelName.withStyle(headerStyle)
    descriptionLabel.attributedText = object.description.withStyle(captionStyle)
    
    activityIndicator.alpha = 1.0
    activityIndicator.startAnimating()
    imageView.setImageFaded(with: URL(string: object.imageURLString)) {
      self.activityIndicator.alpha = 0.0
      self.activityIndicator.stopAnimating()
    }
  }
  
}

extension SurveyCell: SizeCalculatingCell {
  
  func size(forObject object: Any?, userInfo: [String : AnyObject]?) -> CGSize {
    if let userInfo = userInfo,
      let value = userInfo["size"] as? NSValue {
      return value.cgSizeValue
    }
    
    return CGSize.zero
  }
  
}
