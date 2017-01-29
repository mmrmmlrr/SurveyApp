//
//  DarkNavigationBar.swift
//  SurveyApp
//
//  Created by Aleksey on 28.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import UIKit

class DarkNavigationBar: UINavigationBar {
  
  let blurView = DarkBlurringView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    clipsToBounds = false
    shadowImage = UIImage()
    barStyle = .black
    isTranslucent = true
    setBackgroundImage(UIImage(), for: .default)
    addSubview(blurView)
    tintColor = .white
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    fatalError("Not implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    sendSubview(toBack: blurView)
    
    let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
    var frame = bounds
    
    frame.size.height += statusBarHeight
    frame.origin.y -= statusBarHeight
    blurView.frame = frame
  }
  
}
