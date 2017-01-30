//
//  Survey.swift
//  SurveyApp
//
//  Created by Aleksey on 27.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import Foundation

class Survey {
  
  var hotelName: String = ""
  var description: String = ""
  var imageURLString: String = ""
  var uid = ""
  
  var hashValue: Int {
    return uid.hashValue
  }
  
}

extension Survey: Hashable, Equatable { }

func ==(lhs: Survey, rhs: Survey) -> Bool {
  return lhs.hashValue == rhs.hashValue
}
