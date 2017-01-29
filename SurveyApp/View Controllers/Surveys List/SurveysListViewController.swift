//
//  SurveysListViewController.swift
//  SurveyApp
//
//  Created by Aleksey on 28.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import UIKit
import SVProgressHUD

class SurveysListViewController: UIViewController {
  
  @IBOutlet private weak var collectionView: UICollectionView!
  @IBOutlet private weak var takeSurveyButton: UIButton!
  @IBOutlet private weak var pageControl: VerticalPageControl!

  private let model = SurveysListModel()
  private var adapter: CollectionViewAdapter<Survey>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "SURVEYS" //TODO: Localize
    
    addRefreshButton()
    setupTableView()
    subscribeForUpdatesInModel()
    
    model.fetchSurveys()
  }
  
  private func addRefreshButton() {
    let button = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0))
    button.setImage(UIImage(named: "refresh_icon"), for: .normal)
    button.selectionSignal.subscribeNext { [weak self] in
      self?.model.fetchSurveys()
      self?.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
      self?.pageControl.currentPage = 0
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
      
      self?.model.highlightItem(at: IndexPath(row: currentPage, section: 0))
      
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
    
    model.isFetchingSurveys.subscribeNext { isFetching in
      isFetching ? SVProgressHUD.show() : SVProgressHUD.dismiss()
    }.ownedBy(self)
  }
  
  @IBAction
  private func takeSurvey(sender: AnyObject?) {
    let detailsModel = model.createDetailsModelForHighlightedItem()
    let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: SurveyDetailsViewController.self)) as! SurveyDetailsViewController //TODO: make generic
    controller.model = detailsModel
    navigationController?.pushViewController(controller, animated: true)
  }
  
  @IBAction
  private func selectPage(sender: VerticalPageControl) {
    collectionView.scrollToItem(at: IndexPath(item: sender.currentPage, section: 0), at: .centeredVertically, animated: true)
  }
  
  @objc
  private func refresh(sender: AnyObject?) {
    model.fetchSurveys()
  }
  
}
