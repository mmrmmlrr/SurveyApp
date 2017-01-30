//
//  SurveysListViewController.swift
//  SurveyApp
//
//  Created by Aleksey on 28.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import UIKit
import SVProgressHUD

class SurveysListViewController: UIViewController, ContainedInSurveyNavigationController {
  
  @IBOutlet private weak var collectionView: UICollectionView!
  @IBOutlet private weak var takeSurveyButton: UIButton!
  @IBOutlet private weak var pageControl: VerticalPageControl!

  private let model = SurveysListModel()
  private var adapter: CollectionViewAdapter<Survey>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "surveys_list.navigation.title".localized
    takeSurveyButton.setAttributedTitle("surveys_list.take_survey_button.title".localized.withStyle(.bigButton),
                                        for: .normal)
    addRefreshButton()
    setupTableView()
    subscribeForUpdatesInModel()
    
    model.fetchSurveys()
  }
  
  // MARK: Decoration
  
  private func addRefreshButton() {
    let button = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0))
    button.setImage(UIImage(named: "refresh_icon"), for: .normal)
    button.selectionSignal.subscribeNext { [weak self] in
      self?.model.fetchSurveys()
    }.ownedBy(self)
    let refreshButtonItem = UIBarButtonItem(customView: button)
    navigationItem.leftBarButtonItem = refreshButtonItem
  }
  
  private func setupTableView() {
    adapter = CollectionViewAdapter(dataSource: model.surveysDataAdapter, collectionView: collectionView)
    adapter.registerCellClass(SurveyCell.self)
    adapter.nibNameForObjectMatching = { _ in return String(describing: SurveyCell.self) }
    adapter.userInfoForCellSizeMatching = { [weak self] _ in
      return ["size": NSValue(cgSize: self!.collectionView.frame.size)]
    }
    
    adapter.isDragging.subscribeNext { [weak self] _, isDragging in
      UIView.animate(withDuration: 0.15) {
        self?.takeSurveyButton.alpha = isDragging ? 0.0 : 1.0
      }
    }.ownedBy(self)
    
    adapter.didEndDecelerating.subscribeNext { [weak self] _ in
      guard let _self = self else { return }
      
      let pageHeight = _self.collectionView.frame.size.height
      let currentPage = Int(_self.collectionView.contentOffset.y / pageHeight)
      
      _self.model.highlightItem(at: IndexPath(row: currentPage, section: 0))
    }.ownedBy(self)
  }
  
  private func subscribeForUpdatesInModel() {
    model.indexPathOfHighlightedItem.subscribeNext { [weak self] in
      self?.pageControl.currentPage = $0.row
    }.ownedBy(self)
    
    model.surveysDataAdapter.reloadDataSignal.subscribeNext { [weak self] in
      guard let _self = self else { return }
      _self.pageControl.numberOfPages = _self.model.surveysDataAdapter.numberOfObjectsInSection(0)
    }.ownedBy(self)
    
    model.isFetchingSurveys.subscribeNext { [weak self] isFetching in
      isFetching ? SVProgressHUD.show() : SVProgressHUD.dismiss()
      self?.takeSurveyButton.isHidden = isFetching
    }.ownedBy(self)
    
    model.surveysDataAdapter.reloadDataSignal.subscribeNext { [weak self] in
      self?.collectionView.scrollToItem(at: IndexPath.zero, at: .top, animated: false)
      self?.pageControl.currentPage = 0
    }.ownedBy(self)
    
    model.didReceiveError.subscribeNext { [weak self] in
      self?.showAlert(for: $0)
    }.ownedBy(self)
  }
  
  // MARK: Actions
  
  @IBAction
  private func takeSurvey(sender: AnyObject?) {
    surveyNavigationController?.viewController(self, didRequestShowDetailsFor: model.highlightedSurvey())
  }
  
  @IBAction
  private func selectPage(sender: VerticalPageControl) {
    collectionView.scrollToItem(at: IndexPath(item: sender.currentPage, section: 0),
                                at: .centeredVertically,
                                animated: true)
  }
    
  // MARK: Alerts

  func showAlert(for error: Error) {
    let alertController = UIAlertController(
      title: "alert.error.title".localized,
      message: error.localizedDescription,
      preferredStyle: .alert
    )
    alertController.addAction(UIAlertAction(title: "alert.action.accept".localized, style: .default))
    present(alertController, animated: true)
  }
  
}
