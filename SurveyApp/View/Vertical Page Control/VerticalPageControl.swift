//
//  VerticalPageControl.swift
//  SurveyApp
//
//  Created by Aleksey on 29.01.17.
//  Copyright © 2017 aleksey chernish. All rights reserved.
//

import UIKit

class VerticalPageControl: UIControl {
  
  var numberOfPages: Int = 0 {
    didSet { layoutContent() }
  }
  
  var maxNumberOfPages = 30
  
  var currentPage: Int = 0 {
    didSet { self.selectPage(at: currentPage) }
  }
  
  private var buttons = [UIButton]()
  
  private lazy var contentContainer: UIView = {
    let view = UIView()
    self.addSubview(view)
    
    return view
  }()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    backgroundColor = .clear
    clipsToBounds = false
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layoutContent()
  }
  
  private struct Sizes {
    static var buttonEdge: CGFloat = 10.0
    static var gap: CGFloat = 5.0
  }
  
  private func layoutContent() {
    buttons.forEach { $0.removeFromSuperview() }
    buttons = []
    
    let numberOfPages = min(maxNumberOfPages, self.numberOfPages)
    
    var nextButtonY: CGFloat = 0.0
    for n in 0..<numberOfPages {
      defer { nextButtonY += Sizes.buttonEdge + Sizes.gap }
      let button = UIButton(frame: CGRect(x: 0, y: nextButtonY, width: Sizes.buttonEdge, height: Sizes.buttonEdge))
      button.tag = n
      button.setImage(UIImage(named: "page_button_selected"), for: .selected)
      button.setImage(UIImage(named: "page_button_unselected"), for: .normal)
      button.isSelected = n == currentPage
      button.addTarget(self, action: #selector(VerticalPageControl.selectPage(sender:)), for: .touchUpInside)
      contentContainer.addSubview(button)
      buttons.append(button)
    }
    
    let totalContentHeight: CGFloat = CGFloat(numberOfPages) * Sizes.buttonEdge + CGFloat(numberOfPages - 1) * Sizes.gap
    
    contentContainer.frame = CGRect(
      x: 0.0,
      y: (frame.size.height - totalContentHeight) / 2.0,
      width: Sizes.buttonEdge,
      height: totalContentHeight
    )
  }
  
  @objc
  private func selectPage(sender: UIButton) {
    currentPage = sender.tag
    sendActions(for: .valueChanged)
  }
  
  private func selectPage(at index: Int) {
    buttons.forEach { $0.isSelected = $0.tag == index }
  }
  
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    guard !clipsToBounds && !isHidden && alpha != 0.0 else { return nil }
    
    for member in self.subviews.reversed() {
      let subPoint = member.convert(point, from: self)
      if let result = member.hitTest(subPoint, with:event) {
        return result;
      }
    }
    
    return nil
  }
  
}
