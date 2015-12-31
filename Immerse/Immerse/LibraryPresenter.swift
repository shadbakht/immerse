//
//  LibraryPresenter.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
import RATreeView

class LibraryPresenter: NSObject {

  weak var view : LibraryView? = nil
  var interactor : LibraryInteractor? = nil
  
  var isSetup : Bool = false
  var mapping : NSArray = []
  
  func setup() {
    if !isSetup {
      mapping = interactor!.loadFolderMappings()
      isSetup = true
    }
  }
  
  func selectWriting(data:RAObject) {
    interactor!.selectWritingNamed(data.pathName)
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