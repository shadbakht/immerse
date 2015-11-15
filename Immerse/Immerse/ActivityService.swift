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
    if count > all.count {
      return all
    } else {
      let unique = NSSet(array: all as [AnyObject])
      let sort = NSSortDescriptor(key: "view_date", ascending: false)
      let sorted = unique.sortedArrayUsingDescriptors([sort]) as NSArray
      let subset : NSArray = sorted.subarrayWithRange(NSMakeRange(0, count))
      
      return subset.reverseObjectEnumerator().allObjects
    }
  }
}
