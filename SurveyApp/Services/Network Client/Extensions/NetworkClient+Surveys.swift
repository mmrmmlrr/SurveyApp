//
//  NetworkClient+Surveys.swift
//  SurveyApp
//
//  Created by Aleksey on 26.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import Alamofire

extension NetworkClient {
  
  func getSurveys() -> Pipe<NetworkResponse<[String: AnyObject]>> {
    
    var params = [String: AnyObject]()
    params["page"] = 1 as AnyObject
    params["per_page"] = 2 as AnyObject
    
    return NetworkClient.shared.executeRequest(
      path: "surveys.json",
      method: HTTPMethod.get,
      parameters: params,
      serializer: SurveysSerializer()
    )
  }
}
