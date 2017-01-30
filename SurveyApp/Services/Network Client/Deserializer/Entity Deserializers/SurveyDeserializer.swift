//
//  SurveyDeserializer.swift
//  SurveyApp
//
//  Created by Aleksey on 27.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import Foundation

class SurveyDeserializer: EntityDeserializer<Survey> {
  
  override func deserializeRepresentation(_ representation: Any) -> Survey? {
    guard let representation = representation as? [String: AnyObject] else { return nil }
    
    let survey = Survey()
    survey.hotelName = representation["title"] as? String ?? ""
    survey.imageURLString = representation["cover_image_url"] as? String ?? ""
    survey.description = representation["description"] as? String ?? ""
    survey.uid = representation["id"] as! String
    
    return survey
  }
  
}
