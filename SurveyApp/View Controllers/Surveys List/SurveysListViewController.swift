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
  @IBOutlet private weak var takeSurveyButton: UIButton!
  
  private let model = SurveysListModel()
  private var adapter: CollectionViewAdapter<Survey>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    adapter = CollectionViewAdapter(dataSource: model.surveysDataAdapter, collectionView: collectionView)
    adapter.registerCellClass(SurveyCell.self)
    adapter.nibNameForObjectMatching = { _ in return String(describing: SurveyCell.self) }
    adapter.userInfoForCellSizeMatching = { [weak self] _ in
      return ["size": NSValue(cgSize: self!.collectionView.frame.size)]
    }
    
    adapter.isDragging.subscribeNext { [weak self] _, isDragging in
      UIView.animate(withDuration: 0.3) {
        self?.takeSurveyButton.alpha = isDragging ? 0.0 : 1.0
      }
    }.ownedBy(self)
    
    adapter.didEndDecelerating.subscribeNext { [weak self] _ in
      if let indexPaths = self?.collectionView.indexPathsForVisibleItems,
      let indexPath = indexPaths.first {
        self?.model.highlightItem(at: indexPath)
      }
    }.ownedBy(self)
    
    model.fetchSurveys()
  }
  
  @IBAction private func takeSurvey(sender: AnyObject?) {
    let detailsModel = model.createDetailsModelForHighlightedItem()
    let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: SurveyDetailsViewController.self)) as! SurveyDetailsViewController
    controller.model = detailsModel
    navigationController?.pushViewController(controller, animated: true)
  }
  
}
