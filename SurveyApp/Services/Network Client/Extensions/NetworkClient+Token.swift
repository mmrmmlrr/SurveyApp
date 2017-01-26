//
//  NetworkClient+Token.swift
//  SurveyApp
//
//  Created by Aleksey on 26.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import Alamofire

extension NetworkClient {
  
  func refreshToken() -> Pipe<NetworkResponse<String>> {
    var params = [String: AnyObject]()
    params["grant_type"] = "password" as AnyObject?
    params["username"] = "carlos@nimbl3.com" as AnyObject?
    params["password"] = "antikera" as AnyObject?
    
    return NetworkClient.shared.executeRequest(
      path: "oauth/token",
      method: HTTPMethod.post,
      parameters: params,
      signed: false,
      serializer: TokenSerializer()
    )
  }
  
}
