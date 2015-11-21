//
//  AddCrossRefInteractor.swift
//  Immerse
//
//  Created by James Tan on 11/20/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

class AddCrossRefInteractor: NSObject {

  static let sharedInstance : AddCrossRefInteractor = AddCrossRefInteractor()
  var presenter : AddCrossRefPresenter? = nil
  
  func selectWritingNamed(name:String) {
    DataManager.selectWriting(name)
    
  }
  
  func loadFolderMappings() -> NSArray {
    return DataManager.getFolderMapping()
  }
  
  func childrenForPath(name:String) -> NSArray {
    let matches = DataManager.childrenForPath(name)
    let keys = matches.allKeys
    return keys
  }

}
