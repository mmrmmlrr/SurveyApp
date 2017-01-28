//
//  SurveysListModel.swift
//  SurveyApp
//
//  Created by Aleksey on 28.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import Foundation

class SurveysListModel {
  
  private(set) lazy var surveysDataAdapter: OrderedListDataAdapter<Survey> = {
    let adapter = OrderedListDataAdapter(list: self.surveysList)
    
    return adapter
  }()
  
  private let surveysList = OrderedList<Survey>()
  
  private let pool = AutodisposePool()
  
  private var subscriptionForSurveysRequest: Disposable?
  
  func fetchSurveys() {
    subscriptionForSurveysRequest?.dispose()
    subscriptionForSurveysRequest = NetworkClient.shared.getSurveys().subscribeNext { [weak self] response in
      switch response {
      case .success(let surveys):
        self?.surveysList.replaceWith(surveys)
      case .failure(_):
        break //TODO: show error
      }
    }.putInto(pool)
  }
  
}
