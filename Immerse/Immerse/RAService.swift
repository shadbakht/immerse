//
//  RAService.swift
//  Immerse
//
//  Created by James Tan on 11/10/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

class RAService: NSObject {
  static var mapping : NSArray = [] // Publicly Accessible Mappings
  static let folderNames : NSArray = [
    "1 - Bahá’í",
    "2 - Buddhist",
    "4 - Hindu",
    "5 - Islamic",
    "6 - Jewish",
    "7 - Zoroastrian",
    "8 - More",
  ] // Folder Names of Interest
  
  class func recursivelyBuildMapping() {
    /**
     recursivelyBuildMapping
     Maps out the complete structure of the resourcePath for the bundle, then selects
     only those parent levels whose names match those found RAService.folderNames
     */
    
    let path = NSBundle.mainBundle().resourcePath!
    let enumerator = NSFileManager.defaultManager().enumeratorAtPath(path)
    
    var parent : RAObject? = nil
    var parentName : String? = nil
    var lastFolder : RAObject? = nil
    let folderCollections : NSMutableArray = []
    
    
    while let filePath = enumerator?.nextObject() as? String {
    
      let lastItem = filePath.componentsSeparatedByString("/").last
      let itemCount = filePath.componentsSeparatedByString("/").count
      
      if lastItem != nil {
        
        if itemCount == 1 && !lastItem!.hasSuffix(".txt") {
          if lastItem != parentName && parentName != nil{
            // Add the parent to the collection
            // This condition tests that our parent in examination has changed
            // The previous parent is deemed complete
            folderCollections.addObject(parent!)
          }
          parentName = lastItem
          parent = createFolder(lastItem!, path: lastItem!)
          lastFolder = parent
          continue
        }
        
        if !lastItem!.hasSuffix(".txt") {
          let folder = createFolder(lastItem!, path: lastItem!)
          
          if (itemCount >= 3)  {
            lastFolder?.addChild(folder)
          } else {
            parent?.addChild(folder)
          }
          
          lastFolder = folder
          continue
        }
        
        if lastItem!.hasSuffix(".txt") {
          // The enumerator drills down a folder before across. So we know with good certainty that the .txt
          // of interest lies at theend of the tree, so we can just add them to the latest parent child.
          // Can also add writings to the parent if there are no children nodes
          let file = createWriting(lastItem!)
          lastFolder?.addChild(file)
          continue
        }
      }
      
    }
    
    // Cut off the top, those are the folders of interest.
    // Otherwise we'll get everything in the bundle.
    let finalSet : NSMutableArray = []
    for parent in folderCollections {
      let parentObj = parent as! RAObject
      if RAService.folderNames.containsObject(parentObj.pathName) {
        finalSet.addObject(parent)
      }
    }
    RAService.mapping = finalSet.copy() as! NSArray
    
  }

  private class func createFolder(display:String, path:String, children:NSArray = [] ) -> RAObject {
    let object = RAObject()
    
    object.configure(display, pathName: path, children: children as! [RAObject])
    return object
  }
  private class func createWriting(name:String) -> RAObject {
    let object = RAObject()
    object.configure(name.stringByReplacingOccurrencesOfString(".txt", withString: ""),
      pathName: name,
      children: [])
    return object
  }
  private class func setChildren() -> RAObject {
    let object = RAObject()
    return object
  }
}
