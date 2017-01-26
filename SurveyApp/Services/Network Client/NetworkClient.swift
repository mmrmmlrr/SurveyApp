//
//  NetworkClient.swift
//  SurveyApp
//
//  Created by Aleksey on 25.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import Alamofire

private class Retrier: RequestRetrier {
  
   func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
    print("I RETRY")
  }
}

class NetworkClient {
  
  private let retrier = Retrier()
  
  static let shared = NetworkClient()
  
  init() {
    SessionManager.default.retrier = retrier
  }
  
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
      headers: headers()).responseJSON { [weak self]response in
        print(response)
        if let value = response.value as? [String: Any],
          let status = value["status"] as? Int {
          print("STATUS")
          self?.refreshToken().subscribeNext { tokenResponse in
            print(tokenResponse)
          }.autodispose()
          print(status)
        }
        signal.sendNext(response as? T)
    }
    
    signal.destructor = { req.cancel() }

    return signal
  }

}

