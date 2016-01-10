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
    let data : RAObjectReference = item as! RAObjectReference
    let level = tree.levelForCellForItem(item)
    if level == 0 {
      if let cell = tree.dequeueReusableCellWithIdentifier("RefCell") as? RefCell {
        cell.load(data)
        return cell
      }
    }
    if level == 1 {
      if let cell = tree.dequeueReusableCellWithIdentifier("RefCellText") as? RefCellText {
        cell.load(data)
        return cell
      }
    }
    return UITableViewCell()
  }

}
