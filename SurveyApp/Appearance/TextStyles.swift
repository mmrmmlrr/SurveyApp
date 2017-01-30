//
//  TextStyles.swift
//  SurveyApp
//
//  Created by Aleksey on 28.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import HandyText

extension TextStyle {
  
  private static var basicWhiteText: TextStyle {
    return TextStyle(font: .avenir).withForegroundColor(.white).withSize(18.0).regular()
  }
  
  static var navigationHeader: TextStyle {
    return TextStyle.based(on: basicWhiteText).heavy().withSize(20.0)
  }
  
  static var largeHeader: TextStyle {
    return TextStyle.based(on: basicWhiteText).heavy().withSize(30.0)
  }
  
  static var smallCaption: TextStyle {
    return TextStyle.based(on: basicWhiteText)
  }
  
  static var bigButton: TextStyle {
    return TextStyle.based(on: basicWhiteText)
  }
  
}
