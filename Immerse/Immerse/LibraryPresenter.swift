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

  static let sharedInstance : LibraryPresenter = LibraryPresenter()
  var view : LibraryView? = nil
  var interactor : LibraryInteractor? = nil
  
  var isSetup : Bool = false
  var mapping : NSDictionary = [:]
  var folder : NSDictionary = [:]
  
  func setup() {
    if !isSetup {
      mapping = interactor!.loadFolderMappings()
      isSetup = true
    }
  }

  func numberOfChildren(tree:RATreeView, index:AnyObject?) -> Int {
    if mapping.count == 0 { return 0 }
    if folder.count != 0 {
      return folder.count
    }
    if index == nil { // Library View Launch - Parents Only
      return mapping.count
    }
    // Library Children
    let key = mapping.allKeys[index as! Int]
    return (mapping.objectForKey(key)?.count)!
  }

  func selectRowForTree(tree:RATreeView, index:AnyObject?) {
    let key = (mapping.allKeys as NSArray)[index as! Int] as! String
    folder = mapping.objectForKey(key) as! NSDictionary
  }

  func cellForTree(tree:RATreeView, index:AnyObject?) -> UITableViewCell {
    if folder.count > 0 {
      let cell = UITableViewCell()
      let text = (folder.allKeys as NSArray)[index as! Int]
      cell.textLabel!.text = text as! String
      return cell
    }
    
    let cell = UITableViewCell()
    let text = (mapping.allKeys as NSArray).firstObject
    cell.textLabel!.text = text as! String
    print("Fetching cell")
    print(index)
    return cell
  }
}