//
//  NotesView.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
import RATreeView
import KYDrawerController

class NotesView: UIViewController, RATreeViewDelegate, RATreeViewDataSource {

  var presenter : NotesPresenter? = nil
  @IBOutlet weak var noteTreeView : RATreeView!

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setup the VIPER Stack
    let p = NotesPresenter()
    let i = NotesInteractor()
    presenter = p
    presenter?.view = self
    presenter?.interactor = i
    i.presenter = presenter
    
    presenter?.setup()
    
    // Setup the Delegate and DataSource
    noteTreeView.delegate = self
    noteTreeView.dataSource = self
    
    // Register the Cells
    self.noteTreeView.registerNib(
      UINib(nibName: "TagCell", bundle: nil),
      forCellReuseIdentifier: "TagCell"
    )
    self.noteTreeView.registerNib(
      UINib(nibName: "TagCellText", bundle: nil),
      forCellReuseIdentifier: "TagCellText"
    )
    
    // Observe
    Util.observe(self, action: "reload", named: "ReloadNoteView")

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func menuOpen(sender: UIBarButtonItem) {
    if let drawerController = navigationController?.parentViewController as? KYDrawerController {
      drawerController.setDrawerState(.Opened, animated: true)
    }
  }
  
  //MARK: RATreeView Delegate
  func treeView(treeView: RATreeView, didSelectRowForItem item: AnyObject) {
    treeView.deselectRowForItem(item, animated: false)
    let level = treeView.levelForCellForItem(item)
    if level == 1 {
      presenter?.goToWriting(item)
    }
  }
  
  //MARK: RATreeView DataSource
  func treeView(treeView: RATreeView, heightForRowForItem item: AnyObject) -> CGFloat {
    let level = treeView.levelForCellForItem(item)
    if level == 1 { return 100 }
    return 50
  }
  func treeView(treeView: RATreeView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
    if item == nil {
      return presenter!.notes.objectAtIndex(index)
    }
    let data : RAObject = item as! RAObject
    return data.children.objectAtIndex(index)
  }
  
  func treeView(treeView: RATreeView, numberOfChildrenOfItem item: AnyObject?) -> Int {
    if item == nil {
      return presenter!.notes.count
    } else {
      let data : RAObject = item as! RAObject
      return data.children.count
    }
  }
  
  func treeView(treeView: RATreeView, cellForItem item: AnyObject?) -> UITableViewCell {
    let cell = presenter!.cellForTreeView(self.noteTreeView, item: item)
    if cell is TagCell {
//      (cell as! TagCell).configureMode(edit)
    }
    return cell
  }


}
