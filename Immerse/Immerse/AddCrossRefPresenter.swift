//
//  AddCrossRefPresenter.swift
//  Immerse
//
//  Created by James Tan on 11/20/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
import RATreeView

class AddCrossRefPresenter: NSObject {

  static let sharedInstance : AddCrossRefPresenter = AddCrossRefPresenter()
  var view : AddCrossRefView? = nil
  var interactor : AddCrossRefInteractor? = nil
  
  var isSetup : Bool = false
  var mapping : NSArray = []
  
  func setup() {
    if !isSetup {
      mapping = interactor!.loadFolderMappings()
      isSetup = true
    }
  }
  
  func selectWritingForXRef(data:RAObject) {
    interactor!.selectWritingForXRef(data.pathName)
  }
  
  func cellForTreeView(tree:RATreeView, item: AnyObject!) -> UITableViewCell {
    let data : RAObject = item as! RAObject
    let level = tree.levelForCellForItem(item)
    
    let cell = tree.dequeueReusableCellWithIdentifier("LibraryCell") as! LibraryViewCell
    cell.configure(level, data: data)
    cell.selectionStyle = UITableViewCellSelectionStyle.None
    return cell
  }

}
