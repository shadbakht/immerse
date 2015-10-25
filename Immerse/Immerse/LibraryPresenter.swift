//
//  LibraryPresenter.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

class LibraryPresenter: NSObject {

  static let sharedInstance : LibraryPresenter = LibraryPresenter()
  var view : LibraryView? = nil
  var interactor : LibraryInteractor? = nil
  
  var isSetup : Bool = false
  var topLevel : NSArray = []
  var mapping : NSMutableDictionary = [:]
  func setup() {
    if !isSetup {
      topLevel = (interactor?.getTopLevelFolders())!
      isSetup = true
    }
  }
  
  func selectCell(indexPath:NSIndexPath) {
    let section = indexPath.section
    let row = indexPath.row
    let sectionName = topLevel.objectAtIndex(section)
    let list = mapping.objectForKey(sectionName)
    let pathName : String = (sectionName as! String) + "/" + (list!.objectAtIndex(row) as! String)
    interactor?.selectWritingNamed(pathName) // Select the first one for now.
  }
  
  func cellForRow(tableView:UITableView, indexPath:NSIndexPath) -> UITableViewCell {
    let section = indexPath.section
    let sectionName = topLevel.objectAtIndex(section)
    let list = mapping.objectForKey(sectionName)
    
    var title = "Hello"
    if indexPath.row < list!.count {
      title = (list?.objectAtIndex(indexPath.row))! as! String
    }
    let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("LibraryCell", forIndexPath: indexPath)
    cell.textLabel!.text = title
    return cell
  }
  
  func numberOfSections() -> Int {
    return topLevel.count
  }
  
  func titleForSection(section:Int) -> String {
    return topLevel.objectAtIndex(section) as! String
  }
  func numberOfRowsForSection(section:Int) -> Int {
    print("Populating...")
    let name = topLevel.objectAtIndex(section) as! String
    print(name)
    let children = interactor?.childrenForPath(name)
    print(children)
    mapping[name] = children
    return children!.count
  }
}
