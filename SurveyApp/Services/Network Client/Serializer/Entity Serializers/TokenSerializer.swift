//
//  TokenSerializer.swift
//  SurveyApp
//
//  Created by Aleksey on 26.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import Foundation

class TokenSerializer: Serializer<String> {
  
  override func serializeRepresentation(_ representation: [String : AnyObject]) -> String? {
    return representation["access_token"] as? String
  }
  
}
