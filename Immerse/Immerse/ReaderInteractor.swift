//
//  ReaderInteractor.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

class ReaderInteractor: NSObject {

  static let sharedInstance : ReaderInteractor = ReaderInteractor()
  var presenter : ReaderPresenter? = nil
  
  func getCurrentBody() -> String {
    return DataManager.getCurrentBody()
  }
}
