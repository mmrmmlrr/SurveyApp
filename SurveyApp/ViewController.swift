//
//  ViewController.swift
//  SurveyApp
//
//  Created by Aleksey on 25.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import Alamofire

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    NetworkClient.shared.getSurveys().subscribeNext { response in
    }.ownedBy(self)
  }

}

