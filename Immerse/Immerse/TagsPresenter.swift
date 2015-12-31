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
  
  func cellForTreeView(tree:RATreeView, item: AnyObject!) -> UITableViewCell {
    let data : RAObject = item as! RAObject
    let level = tree.levelForCellForItem(item)
    if let cell = tree.dequeueReusableCellWithIdentifier("TagCell") as? TagCell {
      cell.set(data.displayName, level: level, id: data.id)
      return cell
    }
    return UITableViewCell()
  }
}
