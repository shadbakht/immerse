//
//  CrossRefView.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
import KYDrawerController
import RATreeView

class CrossRefView: UIViewController, RATreeViewDelegate, RATreeViewDataSource {
  
  @IBOutlet weak var refTreeView: RATreeView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Delegates
    refTreeView.delegate = self
    refTreeView.dataSource = self
    
    // Get rideof tableview
    refTreeView.treeFooterView = UIView(frame: CGRectZero)

    // Register the Cells
    self.refTreeView.registerNib(
      UINib(nibName: "RefCell", bundle: nil),
      forCellReuseIdentifier: "RefCell"
    )
    self.refTreeView.registerNib(
      UINib(nibName: "RefCellText", bundle: nil),
      forCellReuseIdentifier: "RefCellText"
    )

    Util.observe(self, action: #selector(CrossRefView.reload), named: "ReloadRefView")

  }

  func reload() {
    refTreeView.reloadData()
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
//      presenter?.goToWriting(item)
    }
  }
  
  //MARK: RATreeView DataSource
  func treeView(treeView: RATreeView, heightForRowForItem item: AnyObject) -> CGFloat {
    let level = treeView.levelForCellForItem(item)
    if level == 1 { return 100 }
    return 50
  }
  
  func treeView(treeView: RATreeView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
    let data : RAObjectReference = item as! RAObjectReference
    return data.children.objectAtIndex(index)
  }
  
  func treeView(treeView: RATreeView, numberOfChildrenOfItem item: AnyObject?) -> Int {
    let data : RAObjectReference = item as! RAObjectReference
    return data.children.count
  }
  
  func treeView(treeView: RATreeView, cellForItem item: AnyObject?) -> UITableViewCell {
    let cell = UITableViewCell()
    return cell
  }

}
