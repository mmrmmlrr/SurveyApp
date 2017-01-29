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
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
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
    survey1.imageURLString = "https://www.omnihotels.com/-/media/images/hotels/ausctr/pool/ausctr-omni-austin-hotel-downtown-evening-pool.jpg"
    
    let survey2 = Survey()
    survey2.hotelName = "Hotel 2"
    survey2.description = "Description for hotel 2"
    survey2.uid = "02"
    survey2.imageURLString = "https://exp.cdn-hotels.com/hotels/1000000/150000/140600/140596/140596_275_z.jpg"
    
    let survey3 = Survey()
    survey3.hotelName = "Hotel 3"
    survey3.description = "Description for hotel 3"
    survey3.uid = "03"
    survey3.imageURLString = "https://media-cdn.tripadvisor.com/media/photo-s/02/4b/65/5f/hotel-drisco-at-dusk.jpg"
    
    let survey4 = Survey()
    survey4.hotelName = "Hotel 4"
    survey4.description = "Description for hotel 4"
    survey4.uid = "04"
    survey4.imageURLString = "https://exp.cdn-hotels.com/hotels/1000000/150000/140600/140596/140596_275_z.jpg"

    return [survey1, survey2, survey3, survey4, Survey(), Survey(), Survey()]
  }
}



