//
//  CollectionDeserializer.swift
//  SurveyApp
//
//  Created by Aleksey on 27.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import Foundation

final class CollectionDeserializer<T>: Deserializer {
  
  typealias ObjectType = T
  
  private let elementDeserializer: EntityDeserializer<T>
  
  init(_ deserializer: EntityDeserializer<T>) {
    elementDeserializer = deserializer
  }
  
  func deserializeRepresentation(_ representation: Any) -> [T]? {
    if let dictionaries = representation as? [[String: AnyObject]] {
      return dictionaries.flatMap { elementDeserializer.deserializeRepresentation($0) }
    }
    
    return nil
  }
  
}

extension EntityDeserializer {
  
  func collection() -> CollectionDeserializer<T> {
    return CollectionDeserializer(self)
  }
  
}
