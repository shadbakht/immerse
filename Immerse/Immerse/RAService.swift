//
//  RAService.swift
//  Immerse
//
//  Created by James Tan on 11/10/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

class RAService: NSObject {
  static var mapping : NSArray = []
  
  class func recursivelyBuildMapping() {
    
    let path = NSBundle.mainBundle().resourcePath!
    let enumerator = NSFileManager.defaultManager().enumeratorAtPath(path)
    var filePaths = [String]()
    
    var currentParent : String = ""
    var currentChild : String = ""
    
    var currentParentObj : RAObject? = nil
    let completedTrees : NSMutableArray = []
    
    
    
    while let filePath = enumerator?.nextObject() as? String {
      let path = NSURL(fileURLWithPath: filePath)
      let array : NSArray = filePath.componentsSeparatedByString("/")
      
      if array.count == 1 && path.pathExtension != "txt" {
        currentParent = array.firstObject as! String
        currentParentObj = createFolder(currentParent, path: currentParent)
        print(currentParent)
      }
      if array.count == 2 && path.pathExtension != "txt" {
        currentChild = array.objectAtIndex(1) as! String
        print(currentChild)
      }
      if path.pathExtension == "txt" {
        filePaths.append(filePath)
      }
      
    }
  }

  private class func createFolder(display:String, path:String, children:NSArray = [] ) -> RAObject {
    let object = RAObject()
    object.configure(display, pathName: path, children: children as! [RAObject])
    return object
  }
  private class func createWriting(name:String) -> RAObject {
    let object = RAObject()
    return object
  }
  private class func setChildren() -> RAObject {
    let object = RAObject()
    return object
  }
}
