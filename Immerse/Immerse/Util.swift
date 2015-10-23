//
//  Util.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

class Util: NSObject {
  
  //MARK: Default Handlers
  class func storeDefault(key:String, value:AnyObject?) {
    NSUserDefaults.standardUserDefaults().setObject(value, forKey: key)
    NSUserDefaults.standardUserDefaults().synchronize()
  }
  
  class func defaultValue(key:String)-> AnyObject? {
    return NSUserDefaults.standardUserDefaults().valueForKey(key)
  }
  
  class func removeDefaultWithKey(key:String) {
    NSUserDefaults.standardUserDefaults().removeObjectForKey(key)
    NSUserDefaults.standardUserDefaults().synchronize()
  }

  //MARK: Observer Handlers
  class func observe(target:AnyObject, action:Selector, named:String) {
    NSNotificationCenter.defaultCenter().addObserver(target, selector: action, name: named, object: nil)
  }
  class func removeObserve(target:AnyObject, named:String) {
    NSNotificationCenter.defaultCenter().removeObserver(target, name: named, object: nil)
  }

}
