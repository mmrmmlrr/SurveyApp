//
//  SurveyCell.swift
//  SurveyApp
//
//  Created by Aleksey on 28.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import UIKit
import SDWebImage

class SurveyCell: UICollectionViewCell, ObjectConsuming {
  
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var descriptionLabel: UILabel!
  @IBOutlet private weak var imageView: UIImageView!
  
  func applyObject(_ object: Survey) {
    titleLabel.text = object.hotelName
    descriptionLabel.text = object.description
    imageView.setImageFaded(with: URL(string: object.imageURLString))
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
