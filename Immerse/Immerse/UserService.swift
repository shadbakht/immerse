//
//  UserService.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

enum DefaultKey : String {
  case ReaderTheme = "THEME"
  case ReaderSize = "SIZE"
}

class UserService: NSObject {

  class func fetchValue(key:DefaultKey) -> AnyObject? {
    return NSUserDefaults.standardUserDefaults().stringForKey(key.rawValue)
  }
  
  class func setValue(key:DefaultKey, value:String) {
    NSUserDefaults.standardUserDefaults().setValue(value, forKey: key.rawValue)
    NSUserDefaults.standardUserDefaults()
  }
}
