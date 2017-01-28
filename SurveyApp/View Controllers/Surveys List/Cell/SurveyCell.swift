//
//  SurveyCell.swift
//  SurveyApp
//
//  Created by Aleksey on 28.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import UIKit

class SurveyCell: UICollectionViewCell, ObjectConsuming {
  
  func applyObject(_ object: Survey) {
    print(object.hotelName)
  }
  
}

extension SurveyCell: SizeCalculatingCell {
  
  func size(forObject object: Any?, userInfo: [String : AnyObject]?) -> CGSize {
    return CGSize(width: 100.0, height: 100.0)
  }
}
