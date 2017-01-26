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
                      parameters: [String: AnyObject] = [:],
                      signed: Bool = true,
                      serializer: Serializer<T>) -> Pipe<T?> {
    let signal = Pipe<T?>()
    
    var resultingParams = parameters
    if signed {
      resultingParams["access_token"] = credentialsProvider.accessToken as AnyObject?
    }
    print(credentialsProvider.accessToken)
    
    let req = Alamofire.request(
      credentialsProvider.basePath + path,
      method: method,
      parameters: resultingParams,
      encoding: JSONEncoding.default,
      headers: headers()).responseJSON { [weak self]response in
        switch response.result {
        case .success(let value):
          if let representation = value as? [String: AnyObject],
            let object = serializer.serializeRepresentation(representation){
            signal.sendNext(object)
          } else {
            //TODO: throw serialization error
          }
        case .failure(let error):
          print(error)
          //TODO: throw error
        }
        if let value = response.value as? [String: Any],
          let status = value["status"] as? Int, status == 404 {
          self?.refreshToken().subscribeNext { tokenResponse in
            if let token = tokenResponse {
              self?.credentialsProvider.assignNewToken(token)
              self?.executeRequest(path: path, method: method, parameters: parameters, signed: true, serializer: serializer).subscribeNext {
                signal.sendNext($0)
              }.autodispose()
            }
          }.autodispose()
        }
        signal.sendNext(response as? T)
    }
    
    signal.destructor = { req.cancel() }
    
    return signal
  }
  
}

