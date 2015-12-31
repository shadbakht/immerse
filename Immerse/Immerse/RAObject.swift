//
//  RAObject.swift
//  Immerse
//
//  Created by James Tan on 11/10/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

class RAObject: NSObject {
  var children = []
  var displayName = ""
  var pathName = ""
  var id = "" // Used by Tag
  var subDisplayName = "" //Used by Tag
  
  func configure(displayName:String, pathName: String, children: [RAObject]) -> RAObject {
    self.displayName = displayName
    self.children = children
    self.pathName = pathName
    return self
  }
  func addChild(child:RAObject) {
    let addition : NSMutableArray = (children.mutableCopy() as! NSMutableArray)
    addition.addObject(child)
    self.children = addition.copy() as! NSArray
  }
  
  func removeChild(child:RAObject) {
    let subtraction : NSMutableArray = (children.mutableCopy() as! NSMutableArray)
    subtraction.removeObject(child)
    self.children = subtraction.copy() as! NSArray

  }
}
