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
  
  func selectWritingForXRef(name:String) {
  }
  
  func loadFolderMappings() -> NSArray {
    return []
  }
  
  func childrenForPath(name:String) -> NSArray {
    return []
  }

}
