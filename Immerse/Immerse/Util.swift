//
//  Util.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

extension UILabel {
  func setTextForInt(int:Int) {
    self.text = String(format: "%d", int)
  }
}

extension NSFileManager {
  
  static var documentsPath : String {
    return NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
  }
  
  static var localPath : String {
    let path = NSBundle.mainBundle().resourcePath!
    return path
    
  }
  
  class func localPathForItem(item:String) -> String {
    return self.localPath + "/" + item
  }
  
  class func moveFileFromBundleToDocumentDirectory(name:String) {
    let source = NSFileManager.localPath + "/" + name
    let destination = NSFileManager.documentsPath + "/" + name
    do {
      try NSFileManager.defaultManager().removeItemAtPath(destination)
      try NSFileManager.defaultManager().copyItemAtPath(source, toPath: destination)
    } catch let error as NSError {
      print(error)
    }
  }
  
  class func fileExistsInDocumentDirectory(name:String) -> Bool {
    let path = NSFileManager.documentsPath + "\\" + name
    return NSFileManager.defaultManager().fileExistsAtPath(path)
  }
}

extension String {
  func sha1() -> String {
    let data = self.dataUsingEncoding(NSUTF8StringEncoding)!
    var digest = [UInt8](count:Int(CC_SHA1_DIGEST_LENGTH), repeatedValue: 0)
    CC_SHA1(data.bytes, CC_LONG(data.length), &digest)
    let hexBytes = digest.map { String(format: "%02hhx", $0) }
    return hexBytes.joinWithSeparator("")
  }
  
  static func unique() -> String {
    let uuid = NSUUID().UUIDString
    return uuid.sha1()
  }
}

extension UIColor {
  
  static var imBlue : UIColor {
    return rgb(39, g: 55, b: 66)
  }
  
  static var imBackground : UIColor {
    return rgb(249, g: 249, b: 249)
  }
  
  class func rgb(r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
    return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1.0)
  }
}

extension CGRect {
  mutating func setY(val:CGFloat) {
    self = CGRectMake(origin.x, val, width, height)
  }
}

extension Int {
  func stringValue() -> String {
    return "\(self)"
  }
}

class Util: NSObject {
  
  //MARK: Traverse Bundle
  
  //MARK: Default Handlers
  class func notify(name:String) {
    NSNotificationCenter.defaultCenter().postNotificationName(name, object: nil)
  }
  
  class func notifyData(name:String, data:NSDictionary) {
    NSNotificationCenter.defaultCenter().postNotificationName(name, object: nil, userInfo: data as? [NSObject : AnyObject])
  }

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
  
  //MARK: Unique IDs
  class func uniqueString() -> String {
    return NSUUID().UUIDString
  }

  //MARK: Observer Handlers
  class func observe(target:AnyObject, action:Selector, named:String) {
    NSNotificationCenter.defaultCenter().addObserver(target, selector: action, name: named, object: nil)
  }
  class func removeObserve(target:AnyObject, named:String) {
    NSNotificationCenter.defaultCenter().removeObserver(target, name: named, object: nil)
  }
}
