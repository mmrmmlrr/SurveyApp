//
//  CollectionSerializer.swift
//  SurveyApp
//
//  Created by Aleksey on 27.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import Foundation

final class CollectionSerializer<T>: Serializer {
  
  typealias ObjectType = T
  
  private let elementSerializer: EntitySerializer<T>
  
  init(_ serializer: EntitySerializer<T>) {
    elementSerializer = serializer
  }
  
  func serializeRepresentation(_ representation: Any) -> [T]? {
    if let dictionaries = representation as? [[String: AnyObject]] {
      return dictionaries.flatMap { elementSerializer.serializeRepresentation($0) }
    }
    
    return nil
  }
  
}

extension EntitySerializer {
  
  func collection() -> CollectionSerializer<T> {
    return CollectionSerializer(self)
  }
  
}
