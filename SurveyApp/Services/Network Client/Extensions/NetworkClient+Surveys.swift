//
//  NetworkClient+Surveys.swift
//  SurveyApp
//
//  Created by Aleksey on 26.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import Alamofire

extension NetworkClient {
  
  func getSurveys(page: Int = 0, perPage: Int = 10) -> Pipe<NetworkResponse<[Survey]>> {
    
    var params = [String: AnyObject]()
    params["page"] = page as AnyObject
    params["per_page"] = perPage as AnyObject
    
    return NetworkClient.shared.executeRequest(
      path: "surveys.json",
      method: .get,
      parameters: params,
      encoding: URLEncoding.default,
      serializer: SurveyDeserializer().collection()
    )
  }
  
}
