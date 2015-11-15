//
//  HomeInteractor.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

class HomeInteractor: NSObject {

  static let sharedInstance = HomeInteractor()
  var presenter : HomePresenter? = nil
  
  func getRecent() -> NSArray {
    return DataManager.getLatestWritingsOpened(8)
  }
  
  func selectWriting(writing:Writing) {
    DataManager.selectWriting(writing.writing_filepath)
  }
}
