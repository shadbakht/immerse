//
//  LibraryView.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
import KYDrawerController
import RATreeView

class LibraryViewCell : UITableViewCell {
  
  @IBOutlet weak var constraint: NSLayoutConstraint!
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var indentBar: UIView!
  var exists : Bool = false
  
  func configure(level:Int, data:RAObject) {
    
    let name = data.displayName
    let path = data.pathName
    
    if level == 0 {
      self.indentBar.alpha = 0.0
      self.title.textColor = UIColor(red: 42/255, green: 42/255, blue: 42/255, alpha: 1.0)
      self.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    } else if level >= 1 && !path.containsString(".txt")   {
      self.indentBar.alpha = 1.0
      self.title.textColor = UIColor(red: 42/255, green: 42/255, blue: 42/255, alpha: 1.0)
      self.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
    }
    if path.containsString(".txt") {
      self.indentBar.alpha = 1.0
      self.title.textColor = UIColor(red: 93/255, green: 120/255, blue: 137/255, alpha: 1.0)
      self.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
    }
    
    title.text = name
    let leftIndent = CGFloat(11 + 10.0 * Float(level))
    constraint.constant = leftIndent
    
  }
}

class LibraryView: UIViewController, RATreeViewDataSource, RATreeViewDelegate {
  
  @IBOutlet weak var treeView: RATreeView!

  var presenter : LibraryPresenter? = nil
  
  // MARK: Setup
  
  override func viewDidLoad() {
    
    // Setup VIPER Stack
    presenter = LibraryPresenter.sharedInstance
    presenter?.view = self
    presenter?.interactor = LibraryInteractor.sharedInstance
    LibraryInteractor.sharedInstance.presenter = presenter
    LibraryPresenter.sharedInstance.setup()

    // Setup the RATreeView
    treeView.delegate = self
    treeView.dataSource = self
    
    self.treeView.registerNib(UINib(nibName: "LibraryCell", bundle: nil), forCellReuseIdentifier: "LibraryCell")
    
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: Navigation
  
  @IBAction func menuOpen(sender: UIBarButtonItem) {
    if let drawerController = navigationController?.parentViewController as? KYDrawerController {
      drawerController.setDrawerState(.Opened, animated: true)
    }
  }
  
  //MARK: RATreeView Delegate
  
  func treeView(treeView: RATreeView, didSelectRowForItem item: AnyObject) {
    let data : RAObject = item as! RAObject
    if data.pathName.containsString(".txt") {
      presenter!.selectWriting(data)      
    }
    
  }

  // MARK: RATreeView DataSource
  
  func treeView(treeView: RATreeView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
    if item == nil {
      return presenter!.mapping.objectAtIndex(index)
    }
    let data : RAObject = item as! RAObject
    return data.children.objectAtIndex(index)
  }

  func treeView(treeView: RATreeView, numberOfChildrenOfItem item: AnyObject?) -> Int {
    if item == nil {
      return presenter!.mapping.count
    } else {
      let data : RAObject = item as! RAObject
      return data.children.count
    }
  }
  
  func treeView(treeView: RATreeView, cellForItem item: AnyObject?) -> UITableViewCell {
    let cell = presenter!.cellForTreeView(self.treeView, item: item)
    return cell
  }


}
