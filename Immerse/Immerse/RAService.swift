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
    while let filePath = enumerator?.nextObject() as? String {

      print(filePath)
      print(enumerator?.nextObject() as? String)
      if NSURL(fileURLWithPath: filePath).pathExtension == "txt" {
        filePaths.append(filePath)
      }
      
    }
  }
  
//  class func seedData() {
//    
//    let folder = createFolder("Baha'i", path: "1 - Baha'i")
//    let folder2 = createFolder("The Bab", path: "1 - The Bab")
//    let doc = createWriting("Epistle")
//    folder2.children = [doc]
//    let folder3 = createFolder("Bahaulla", path: "2 - Baha'ullah")
//    
//    folder.children = [folder2, folder3]
//    
//  }
  
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
