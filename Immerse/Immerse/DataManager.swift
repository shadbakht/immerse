//
//  DataManager.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

class DataManager: NSObject {

  class func setup() {
    
//    DBBuilder().processFromFilePath()
    
    // Check for Existing Default.Realm file, Copy it if it doesn't exist
    if !NSFileManager.fileExistsInDocumentDirectory("default.realm") {
      NSFileManager.moveFileFromBundleToDocumentDirectory("default.realm")
    }
    
  }
}
