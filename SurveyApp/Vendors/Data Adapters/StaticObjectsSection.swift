//
//  StaticObjectsSection.swift
//  SurveyApp
//
//  Created by Aleksey on 28.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import Foundation

public class StaticObjectsSection<U>: CustomStringConvertible {
  
  public private(set) var title: String?
  public var objects: [U]
  
  public init(title: String?, objects: [U]) {
    self.title = title
    self.objects = objects
  }
  
  public var description: String {
    return String(describing: StaticObjectsSection.self) + ", title: \(title)" + ", objects: \(objects)"
  }
  
  public func copy() -> StaticObjectsSection<U> {
    return StaticObjectsSection(title: title, objects: objects)
  }
  
}
