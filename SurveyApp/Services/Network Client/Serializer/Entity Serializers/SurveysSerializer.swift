//
//  SurveysSerializer.swift
//  SurveyApp
//
//  Created by Aleksey on 26.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import Foundation

class SurveysSerializer: Serializer<[String: AnyObject]> {
  
  override func serializeRepresentation(_ representation: [String : AnyObject]) -> [String: AnyObject]? {
    return representation
  }
  
}
