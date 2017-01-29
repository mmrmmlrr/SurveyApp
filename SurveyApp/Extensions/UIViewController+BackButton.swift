//
//  UIViewController+BackButton.swift
//  SurveyApp
//
//  Created by Aleksey on 28.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import UIKit

extension UIViewController {
  
  func addBackButton() {
    let backItem = UIBarButtonItem(
      image: UIImage(named: "back_button")!.withRenderingMode(.alwaysOriginal),
      style: .plain,
      target: self,
      action: #selector(back)
    )
    navigationItem.hidesBackButton = true
    navigationItem.leftBarButtonItem = backItem
  }
  
  @objc
  private func back(sender: AnyObject?) {
    if ((navigationController?.viewControllers.count)! > 1) {
      _ = navigationController?.popViewController(animated: true)
    }
  }
  
}
