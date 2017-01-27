//
//  EntitySerializer.swift
//  SurveyApp
//
//  Created by Aleksey on 27.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import Foundation

class EntitySerializer<T>: Serializer {
  typealias ObjectType = T
  
  func serializeRepresentation(_ representation: Any) -> T? {
    return representation as? T
  }
  
}
