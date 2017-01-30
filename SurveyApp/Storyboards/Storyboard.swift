//
//  Storyboard.swift
//  SurveyApp
//
//  Created by Aleksey on 30.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import UIKit

enum Storyboard: String {
  
  case main = "Main"
  
  func correspondingController<T: UIViewController>() -> T {
    return UIStoryboard(
      name: rawValue,
      bundle: nil
    ).instantiateViewController(withIdentifier: String(describing: T.self)) as! T
  }
  
}
