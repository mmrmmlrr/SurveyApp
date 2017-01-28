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
    
//    return NetworkClient.shared.executeRequest(
//      path: "surveys.json",
//      method: .get,
//      parameters: params,
//      serializer: SurveyDeserializer().collection()
//    )
    
    let pipe = Pipe<NetworkResponse<[Survey]>>()
    DispatchQueue.main.async {
      pipe.sendNext(.success(self.fakeSurveys()))
    }
    
    return pipe
  }
  
  //TODO: TEMP
  
  private func fakeSurveys() -> [Survey] {
    let survey1 = Survey()
    survey1.hotelName = "Hotel 1"
    survey1.description = "Description for hotel 1"
    survey1.uid = "01"
    
    let survey2 = Survey()
    survey2.hotelName = "Hotel 2"
    survey2.description = "Description for hotel 2"
    survey2.uid = "02"
    
    let survey3 = Survey()
    survey3.hotelName = "Hotel 3"
    survey3.description = "Description for hotel 3"
    survey3.uid = "03"
    
    return [survey1, survey2, survey3]
  }
}



