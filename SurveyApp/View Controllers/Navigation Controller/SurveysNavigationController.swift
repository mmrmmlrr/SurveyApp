//
//  SurveysNavigationController.swift
//  SurveyApp
//
//  Created by Aleksey on 28.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import UIKit

class SurveysNavigationController: UINavigationController {
  
  override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
    super.init(navigationBarClass: DarkNavigationBar.self, toolbarClass: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    let bar = DarkNavigationBar(frame: CGRect.zero)
    setValue(bar, forKey: "navigationBar")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationBar.applyAttributes(from: .navigationHeader)
  }
}
