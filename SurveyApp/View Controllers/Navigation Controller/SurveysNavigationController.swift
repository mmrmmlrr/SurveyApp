//
//  SurveysNavigationController.swift
//  SurveyApp
//
//  Created by Aleksey on 28.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import UIKit

class SurveysNavigationController: UINavigationController, UINavigationControllerDelegate {
  
  override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
    super.init(navigationBarClass: DarkNavigationBar.self, toolbarClass: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    let bar = DarkNavigationBar(frame: CGRect.zero)
    setValue(bar, forKey: "navigationBar")
    delegate = self
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationBar.applyAttributes(from: .navigationHeader)
  }
  
  override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    super.pushViewController(viewController, animated: true)
    addSideMenuButton(to: viewController)
  }
  
  override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
    super.setViewControllers(viewControllers, animated: animated)
    
    viewControllers.forEach { self.addSideMenuButton(to: $0) }
  }
  
  override var viewControllers: [UIViewController] {
    didSet {
      viewControllers.forEach { addSideMenuButton(to: $0) }
    }
  }
  
  override init(rootViewController: UIViewController) {
    super.init(rootViewController: rootViewController)
    addSideMenuButton(to: rootViewController)
  }
  
  func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
    addSideMenuButton(to: viewController)
    
  }
  
  private func addSideMenuButton(to controller: UIViewController) {
    let button = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0))
    button.setImage(UIImage(named: "side_menu_icon"), for: .normal)
    button.selectionSignal.subscribeNext { print("SHOW SIDE MENU") }.ownedBy(self)
    let sideMenuButtonItem = UIBarButtonItem(customView: button)
    controller.navigationItem.rightBarButtonItem = sideMenuButtonItem
  }
  
}
