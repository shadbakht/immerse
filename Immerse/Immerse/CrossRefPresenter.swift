//
//  CrossRefPresenter.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
import RATreeView

class CrossRefPresenter: NSObject {

  weak var view : CrossRefView? = nil
  var interactor : CrossRefInteractor? = nil
  
  var refMapping : NSArray = []
  
  func setup() {
    if let map = interactor?.loadRefMapping() {
      refMapping = map
    }
  }
  
}
