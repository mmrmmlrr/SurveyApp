//
//  NetworkClient+Surveys.swift
//  SurveyApp
//
//  Created by Aleksey on 26.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import Alamofire

extension NetworkClient {
  
  func getSurveys() -> Pipe<[String: AnyObject]?> {
    
    var params = [String: AnyObject]()
    params["page"] = 1 as AnyObject
    params["per_page"] = 10 as AnyObject
    
    let pipe = NetworkClient.shared.executeRequest(
      path: "surveys.json",
      method: HTTPMethod.post,
      parameters: params,
      serializer: SurveysSerializer()
    )
    
    return pipe
  }
}
