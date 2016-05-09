//
//  Progress.swift
//  Immerse
//
//  Created by James Tan on 5/8/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import RealmSwift


class ProgressInterface : GenericModelInterface {
  
  class func createProgress(src:Book, index:Int) {
    print("CREATE : \(index)")
    // @jtan: it might be overshooting by 3 because of the missign headers: title, faith, author.
    if let progress = getProgress(src) {
      RealmService.updateObject(Progress.self, pid: progress.id, keys: ["row", "last_read_date"], values: [index, NSDate()])
    } else {
      let progress = Progress()
      progress.writing = src
      progress.row = index
      RealmService.createObject(progress)
    }
  }
  
  class func getProgress(src:Book) -> Progress? {
    let results = getAllProgress().filter({$0.writing!.isEqual(src)})
    if results.count == 1 {
      print("GET : \(results.first!.row)")
      return results.first
    }
    return nil
  }
  
  class func getAllProgress() -> [Progress] {
    return RealmService.allObjects(Progress.self) as! [Progress]
  }

}

class Progress: Object {
  override static func primaryKey() -> String? {
    return "id"
  }
  
  dynamic var id : String = String.unique()
  dynamic var writing : Book?
  dynamic var row : Int = 0
  dynamic var last_read_date : NSDate = NSDate()
  
  var percent : Float {
    get {
      return Float( Float(self.row) / Float(writing!.records.count))
    }
  }
}
