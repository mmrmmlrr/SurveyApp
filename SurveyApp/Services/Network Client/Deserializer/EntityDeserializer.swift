//
//  EntityDeserializer.swift
//  SurveyApp
//
//  Created by Aleksey on 27.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import Foundation

class EntityDeserializer<T>: Deserializer {
  typealias ObjectType = T
  
  func deserializeRepresentation(_ representation: Any) -> T? {
    return representation as? T
  }
  
}
