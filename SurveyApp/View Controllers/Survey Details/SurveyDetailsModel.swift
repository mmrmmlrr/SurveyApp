//
//  SurveyDetailsModel.swift
//  SurveyApp
//
//  Created by Aleksey on 28.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import Foundation

class SurveyDetailsModel {
  
  var title: String {
    return survey.hotelName
  }
  
  private let survey: Survey
  
  init(_ survey: Survey) {
    self.survey = survey
  }
  
}
