//
//  String+Localization.swift
//  SurveyApp
//
//  Created by Aleksey on 30.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import Foundation

extension String {
  
  var localized: String {
    return NSLocalizedString(self, comment: self)
  }
  
}
