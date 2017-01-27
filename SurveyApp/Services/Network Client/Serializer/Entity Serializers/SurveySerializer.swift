//
//  SurveySerializer.swift
//  SurveyApp
//
//  Created by Aleksey on 27.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import Foundation

class SurveySerializer: EntitySerializer<Survey> {
  
  override func serializeRepresentation(_ representation: Any) -> Survey? {
    return Survey()
  }
  
}
