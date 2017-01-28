//
//  SurveyDeserializer.swift
//  SurveyApp
//
//  Created by Aleksey on 27.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import Foundation

class SurveyDeserializer: EntityDeserializer<Survey> {
  
  override func deserializeRepresentation(_ representation: Any) -> Survey? {
    return Survey()
  }
  
}
