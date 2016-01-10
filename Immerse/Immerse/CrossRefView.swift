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

  var presenter : CrossRefPresenter? = nil
  
  @IBOutlet weak var refTreeView: RATreeView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setup VIPER
    let p = CrossRefPresenter()
    let i = CrossRefInteractor()
    presenter = p
    presenter?.view = self
    presenter?.interactor = i
    i.presenter = presenter
    presenter?.setup()

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

    Util.observe(self, action: "reload", named: "ReloadRefView")

  }

  func reload() {
    presenter?.setup()
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
    if item == nil {
      return presenter!.refs.objectAtIndex(index)
    }
    let data : RAObjectReference = item as! RAObjectReference
    return data.children.objectAtIndex(index)
  }
  
  func treeView(treeView: RATreeView, numberOfChildrenOfItem item: AnyObject?) -> Int {
    if item == nil {
      return presenter!.refs.count
    } else {
      let data : RAObjectReference = item as! RAObjectReference
      return data.children.count
    }
  }
  
  func treeView(treeView: RATreeView, cellForItem item: AnyObject?) -> UITableViewCell {
    let cell = presenter!.cellForTreeView(self.refTreeView, item: item)
    return cell
  }

}
