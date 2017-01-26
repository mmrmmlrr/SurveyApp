//
//  Serializer.swift
//  SurveyApp
//
//  Created by Aleksey on 26.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import Foundation

class Serializer<T> {
  
  func serializeRepresentation(_ representation: [String: AnyObject]) -> T? {
    fatalError() //Implemented by descendants
  }
  
}
