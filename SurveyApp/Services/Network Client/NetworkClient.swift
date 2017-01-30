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
  
  func executeRequest<ResponseObjectType, DeserializerType: Deserializer>(path: String,
                      method: HTTPMethod,
                      parameters: [String: AnyObject] = [:],
                      signed: Bool = true,
                      encoding: ParameterEncoding = URLEncoding.default,
                      serializer: DeserializerType,
                      canRetry: Bool = true) -> Pipe<NetworkResponse<ResponseObjectType>> {
    
    let signal = Pipe<NetworkResponse<ResponseObjectType>>()
    
    var resultingParams = parameters
    if signed {
      resultingParams["access_token"] = credentialsProvider.accessToken as AnyObject?
    }

    let req = Alamofire.request(
      credentialsProvider.basePath + path,
      method: method,
      parameters: resultingParams,
      encoding: encoding,
      headers: headers).validate(contentType: ["application/json"]).responseJSON { [weak self] response in
        switch response.result {
        case .success(let value):
          if let representation = value as? [String: AnyObject],
            let objectDeserializer = serializer as? EntityDeserializer<ResponseObjectType>,
            let object = objectDeserializer.deserializeRepresentation(representation){
            signal.sendNext(.success(object))
          } else if let representation = value as? [[String: AnyObject]],
            let collectionDeserializer = serializer as? CollectionDeserializer<DeserializerType.ObjectType>,
            let objects = collectionDeserializer.deserializeRepresentation(representation) as? ResponseObjectType {
            signal.sendNext(.success(objects))
          }
        case .failure(let error):
          guard canRetry else {
            signal.sendNext(.failure(error))
            
            return
          }
          self?.refreshToken().subscribeNext { tokenResponse in
            if case .success(let token) = tokenResponse {
              self?.credentialsProvider.assignNewToken(token)
              self?.executeRequest(
                path: path,
                method: method,
                parameters: parameters,
                signed: signed,
                serializer: serializer,
                canRetry: false).subscribeNext {
                  signal.sendNext($0)
                }.autodispose()
              }
            }.autodispose()
        }
    }
    signal.destructor = { req.cancel() }
    
    return signal
  }
  
  func killToken() {
    credentialsProvider.assignNewToken("")
  }
  
}
