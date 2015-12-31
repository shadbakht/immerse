//
//  TagsPresenter.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
import RATreeView

class TagsPresenter: NSObject {
  weak var view : TagsView? = nil
  var interactor : TagsInteractor? = nil
  
  var tags : NSArray = []
  
  func setup() {
    tags = interactor!.loadTagMappings()
  }
  
  func goToWriting(data:AnyObject) {
    let item = data as! RAObject
    let writingId = item.id
    interactor?.selectWriting(writingId)
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
