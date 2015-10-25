//
//  LibraryInteractor.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

class LibraryInteractor: NSObject {

  static let sharedInstance : LibraryInteractor = LibraryInteractor()
  var presenter : LibraryPresenter? = nil
  
  func selectWritingNamed(name:String) {
    DataManager.selectWriting(name)
    
  }
  
  func getTopLevelFolders() -> NSArray {
    return DataManager.topLevelItems()
  }
  
  func childrenForPath(name:String) -> NSArray {
    let matches = DataManager.childrenForPath(name)
    let keys = matches.allKeys
    return keys
  }
}
