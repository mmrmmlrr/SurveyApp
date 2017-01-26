//
//  NetworkClient.swift
//  SurveyApp
//
//  Created by Aleksey on 25.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import Alamofire

class NetworkClient {
  
  static let shared = NetworkClient()
  
  private let credentialsProvider: APICredentialsProviding = CredentialsStore()
  
  fileprivate func headers() -> [String : String] {
    var headers = [String : String]()
    headers["Content-Type"] = "application/json"
    
    return headers
  }

  
  func executeRequest<T>(path: String,
                      method: HTTPMethod,
                      parameters: [String: AnyObject]? = nil,
                      encoding: ParameterEncoding) -> Pipe<T?> {
    let signal = Pipe<T?>()
    
    let req = Alamofire.request(
      credentialsProvider.basePath + path,
      method: method,
      parameters: parameters,
      encoding: encoding,
      headers: headers()).responseString { response in
        print(response)
        signal.sendNext(response as? T)
    }
    
    signal.destructor = { req.cancel() }

    return signal
  }

}

