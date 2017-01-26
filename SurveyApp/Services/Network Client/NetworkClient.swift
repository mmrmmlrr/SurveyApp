//
//  NetworkClient.swift
//  SurveyApp
//
//  Created by Aleksey on 25.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import Alamofire

enum NetworkResponse<T> {
  case success(T)
  case failure(Error)
}

class NetworkClient {
  
  static let shared = NetworkClient()

  private let credentialsProvider: APICredentialsProviding = CredentialsStore()
  
  fileprivate var headers: [String : String] = {
    var headers = [String : String]()
    headers["Content-Type"] = "application/json"
    
    return headers
  }()
  
  func executeRequest<T>(path: String,
                      method: HTTPMethod,
                      parameters: [String: AnyObject] = [:],
                      signed: Bool = true,
                      serializer: Serializer<T>) -> Pipe<NetworkResponse<T>> {
    let signal = Pipe<NetworkResponse<T>>()
    
    var resultingParams = parameters
    if signed {
      resultingParams["access_token"] = credentialsProvider.accessToken as AnyObject?
    }
    print(resultingParams)
    
    let req = Alamofire.request(
      credentialsProvider.basePath + path,
      method: method,
      parameters: resultingParams,
      encoding: JSONEncoding.prettyPrinted,
      headers: headers).validate(contentType: ["application/json"]).responseJSON { [weak self] response in
        print(response)
        switch response.result {
        case .success(let value):
          if let representation = value as? [String: AnyObject],
            let object = serializer.serializeRepresentation(representation){
            signal.sendNext(.success(object))
          } else {
//            signal.sendNext(.error(TODO: throw serialization error))
          }
        case .failure(let error):
          signal.sendNext(.failure(error))
        }
        if let value = response.value as? [String: Any],
          let status = value["status"] as? Int, status == 404 {
          self?.refreshToken().subscribeNext { tokenResponse in
            if case .success(let token) = tokenResponse {
              self?.credentialsProvider.assignNewToken(token)
              self?.executeRequest(path: path, method: method, parameters: parameters, signed: true, serializer: serializer).subscribeNext {
                signal.sendNext($0)
              }.autodispose()
            }
          }.autodispose()
        }
    }
    
    signal.destructor = { req.cancel() }
    
    return signal
  }
  
}
