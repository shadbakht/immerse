//
//  GenericModelInterface.swift
//  Immerse
//
//  Created by James Tan on 4/10/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import RealmSwift

class GenericModelInterface : NSObject {
  
  class func getObjectsBy<T>(type:T, name:String, value:AnyObject) -> [Object] {
    var query = "\(name) = \(value)"
    if value is String {
      query = "\(name) = '" + (value as! String) + "'"
    }
    let results = RealmService.objectsWhere(self, query: query )
    return results
  }
}

