//
//  TokenSerializer.swift
//  SurveyApp
//
//  Created by Aleksey on 26.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import Foundation

class TokenSerializer: EntitySerializer<String> {
  
  override func serializeRepresentation(_ representation: Any) -> String? {
    if let dictionary = representation as? [String: AnyObject] {
      return dictionary["access_token"] as? String
    }
    
    return nil
  }
  
}
