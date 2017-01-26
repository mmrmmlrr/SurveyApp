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
    
    
    var params = ["access_token" : "d9584af77d8c0d6622e2b3c554ed520b2ae64ba0721e52daa12d6eaa5e5cdd93" as AnyObject]
    params["page"] = 1 as AnyObject
    params["per_page"] = 10 as AnyObject

//    let params: [String: AnyObject] = ["page": "1", "per_page": "10"]
    let pipe: Pipe<String?> = NetworkClient.shared.executeRequest(
      path: "surveys.json",
      method: HTTPMethod.post,
      parameters: params,
      encoding: JSONEncoding.default
      )
    
    pipe.subscribeNext { print($0) }
 
    
    
//    
//    pipe.subscribeNext { print($0) }

    
    
    

  }

}

