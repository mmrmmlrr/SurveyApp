//
//  TextStyles.swift
//  SurveyApp
//
//  Created by Aleksey on 28.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import HandyText

extension TextStyle {
  
  static var navigationHeader: TextStyle {
    return TextStyle(font: .avenir).withSize(20.0).heavy().withForegroundColor(.white)
  }
  
  static var bigButton: TextStyle {
    return TextStyle(font: .avenir).withSize(18.0).regular().withForegroundColor(.white)
  }
  
}
