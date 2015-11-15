//
//  ActivityService.swift
//  Immerse
//
//  Created by James Tan on 11/14/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

class ActivityService: NSObject {

  class func recordLastWriting(writing:Writing) {
    let act = Activity()
    act.writing_id = writing.writing_id
    act.view_date = NSDate()
    RealmService.createObject(act)
  }
  
  class func getLatestWritings(count:Int) -> NSArray {
    let all = RealmService.allObjectsForType(Activity.self)
    let sort = NSSortDescriptor(key: "view_date", ascending: false)
    let sorted = all.sortedArrayUsingDescriptors([sort]) as NSArray

    
    // Ugly way to fetch the unique items
    let unique : NSMutableArray = []
    let uniqueNames : NSMutableArray = []
    for item in sorted {
      let itemObj = item as! Activity
      if !uniqueNames.containsObject(itemObj.writing_id) {
        uniqueNames.addObject(itemObj.writing_id)
        unique.addObject(item)
      }
    }

    if count > unique.count {
      return unique
    } else {
      let subset : NSArray = unique.subarrayWithRange(NSMakeRange(0, count))
      return subset
    }
  }
}
