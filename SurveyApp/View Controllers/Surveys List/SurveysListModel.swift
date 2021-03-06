//
//  SurveysListModel.swift
//  SurveyApp
//
//  Created by Aleksey on 28.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import Foundation

class SurveysListModel {
  
  let indexPathOfHighlightedItem = Observable(IndexPath.zero)
  let isFetchingSurveys = Observable(false)
  let didReceiveError = Pipe<Error>()
  
  private(set) lazy var surveysDataAdapter: OrderedListDataAdapter<Survey> = {
    return OrderedListDataAdapter(list: self.surveysList)
  }()
  
  private let surveysList = OrderedList<Survey>()
  private let pool = AutodisposePool()
  private var subscriptionForSurveysRequest: Disposable?
  
  deinit {
    subscriptionForSurveysRequest?.dispose()
  }
  
  func fetchSurveys() {
    isFetchingSurveys.sendNext(true)
    subscriptionForSurveysRequest?.dispose()
    subscriptionForSurveysRequest = NetworkClient.shared.getSurveys().subscribeNext { [weak self] response in
      self?.isFetchingSurveys.sendNext(false)
      switch response {
      case .success(let surveys):
        self?.surveysList.replaceWith(surveys)
        self?.indexPathOfHighlightedItem.value = IndexPath.zero
      case .failure(let error):
        self?.didReceiveError.sendNext(error)
      }
    }.putInto(pool)
  }
  
  func highlightItem(at indexPath: IndexPath) {
    indexPathOfHighlightedItem.value = indexPath
  }
  
  func highlightedSurvey() -> Survey {
    return surveysDataAdapter.objectAtIndexPath(indexPathOfHighlightedItem.value)!
  }
  
}
