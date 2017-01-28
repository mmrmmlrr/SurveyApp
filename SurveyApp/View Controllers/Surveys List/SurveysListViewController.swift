//
//  SurveysListViewController.swift
//  SurveyApp
//
//  Created by Aleksey on 28.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import UIKit

class SurveysListViewController: UIViewController {
  
  @IBOutlet private weak var collectionView: UICollectionView!
  
  private let model = SurveysListModel()
  private var adapter: CollectionViewAdapter<Survey>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    adapter = CollectionViewAdapter(dataSource: model.surveysDataAdapter, collectionView: collectionView)
    adapter.registerCellClass(SurveyCell.self)
    adapter.nibNameForObjectMatching = { _ in return String(describing: SurveyCell.self) }
    
    model.fetchSurveys()
  }
  
}
