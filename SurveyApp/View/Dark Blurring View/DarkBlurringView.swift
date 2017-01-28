//
//  DarkBlurringView.swift
//  SurveyApp
//
//  Created by Aleksey on 28.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import UIKit

class DarkBlurringView: UIView {
  
  private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
  private let shadingImageView: UIView = {
    let view = UIView()
    view.backgroundColor = .darkNavy
    view.alpha = 0.7
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubviews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    addSubviews()
  }
  
  private func addSubviews() {
    backgroundColor = .clear
    addSubview(blurView)
    addSubview(shadingImageView)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    blurView.frame = bounds
    shadingImageView.frame = bounds
  }
  
}
