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
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
      pipe.sendNext(.success(self.fakeSurveys()))
    }
    
    return pipe
  }
  
  //TODO: TEMP
  
  
  
  private func fakeSurveys() -> [Survey] {
    let survey1 = Survey()
    survey1.hotelName = "First World Hotel"
    survey1.description = "Description for hotel 1"
    survey1.uid = "01"
    survey1.imageURLString = "https://www.omnihotels.com/-/media/images/hotels/ausctr/pool/ausctr-omni-austin-hotel-downtown-evening-pool.jpg"
    
    let survey2 = Survey()
    survey2.hotelName = "The Palazzo"
    survey2.description = "Description for hotel 2"
    survey2.uid = "02"
    survey2.imageURLString = "https://tripadvisorwatch.files.wordpress.com/2012/01/hotel.jpg"
    
    let survey3 = Survey()
    survey3.hotelName = "Grand Las Vegas"
    survey3.description = "Description for hotel 3"
    survey3.uid = "03"
    survey3.imageURLString = "https://s23.postimg.org/aes40rlzv/images_home6.jpg"
    
    let survey4 = Survey()
    survey4.hotelName = "City Center"
    survey4.description = "Description for hotel 4"
    survey4.uid = "04"
    survey4.imageURLString = "https://s28.postimg.org/47f2h6vml/besthotelsites_1.jpg"
    
    let survey5 = Survey()
    survey5.hotelName = "Sheraton"
    survey5.description = "Description for hotel 5"
    survey5.uid = "05"
    survey5.imageURLString = "https://s27.postimg.org/xvjk3mikj/SHAR_Bg_Hotel_Lobby.jpg"

    return [survey1, survey2, survey3, survey4, survey5]
  }
}



