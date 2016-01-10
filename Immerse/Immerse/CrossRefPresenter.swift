//
//  CrossRefPresenter.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
import RATreeView

class CrossRefPresenter: NSObject {

  weak var view : CrossRefView? = nil
  var interactor : CrossRefInteractor? = nil
  
  var refs : NSArray = []
  
  func setup() {
    if let map = interactor?.loadRefMapping() {
      refs = map
    }
  }
 
  func cellForTreeView(tree:RATreeView, item: AnyObject!) -> UITableViewCell {
    let data : RAObject = item as! RAObject
    let level = tree.levelForCellForItem(item)
    if level == 0 {
      if let cell = tree.dequeueReusableCellWithIdentifier("TagCell") as? TagCell {
        cell.set(data.displayName, level: level, id: data.id)
        return cell
      }
    }
    if level == 1 {
      if let cell = tree.dequeueReusableCellWithIdentifier("TagCellText") as? TagCellText {
        cell.set(data.displayName, level:level, id:data.id, location:data.subDisplayName)
        return cell
      }
    }
    return UITableViewCell()
  }

}
