//
//  TokenDeserializer.swift
//  SurveyApp
//
//  Created by Aleksey on 26.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import Foundation

class TokenDeserializer: EntityDeserializer<String> {
  
  override func deserializeRepresentation(_ representation: Any) -> String? {
    if let dictionary = representation as? [String: AnyObject] {
      return dictionary["access_token"] as? String
    }
    
    return nil
  }
  
}
