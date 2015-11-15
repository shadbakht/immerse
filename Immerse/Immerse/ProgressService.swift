//
//  ProgressService.swift
//  Immerse
//
//  Created by James Tan on 11/14/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

class ProgressService: NSObject {

  class func getProgressForText(text:Writing) -> Float {
    let writing_id = text.writing_id
    let results = RealmService.objectsForQuery(Progress.self, query: "writing_id = '" + writing_id + "'")
    if results.count > 0 {
      return (results.firstObject as! Progress).current_progress
    }
    return 0.0
  }
  
  class func createOrUpdateProgressForText(progress:Float, text:Writing) {
    
    let writing_id = text.writing_id
    
    // Check Realm for Existing Progress
    let results = RealmService.objectsForQuery(Progress.self, query: "writing_id = '" + writing_id + "'")
    if results.count > 0 {
      // Update the Progress
      RealmService.updateObject(Progress.self, keyIdentify: "writing_id", keyValue: writing_id, keys: ["current_progress"], values: [progress])
    } else {
      // Create the Progress
      let progressObj = Progress()
      progressObj.writing_id = writing_id
      progressObj.current_progress = progress
      RealmService.createObject(progressObj)
    }
    
  }
  
}
