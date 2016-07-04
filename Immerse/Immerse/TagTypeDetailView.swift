//
//  TagTypeDetailView.swift
//  Immerse
//
//  Created by James Tan on 4/26/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import UIKit

class TagTypeDetailView: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet var tagList: UITableView!
  @IBOutlet weak var tagDetailToolbar: UIToolbar!
  private var edit : UIBarButtonItem? = nil
  private var selectedTags : [Tag] = []
  private var editSelected : Bool = false
  private var tagViewModel : TagViewModel? = nil
  var tagType : TagType? = nil
  
  @IBOutlet weak var shareButton: UIBarButtonItem!
  @IBOutlet weak var deleteButton: UIBarButtonItem!
  
  override func viewDidLoad() {
    
    self.navigationController?.navigationItem.title = tagType?.name
    
    tagViewModel = TagViewModel(viewController: self)
    tagViewModel?.setup()
    
    // Setup The TableView
    let nib = UINib(nibName: "TagTypeDetail", bundle: nil)
    tagList.registerNib(nib, forCellReuseIdentifier: "TagTypeDetail")
    tagList.delegate = self
    tagList.dataSource = self
    tagList.tableFooterView = UIView(frame: CGRectZero)
    
    self.title = tagType?.name

    edit = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: #selector(toggleEdit))
    self.navigationItem.rightBarButtonItem = edit
    super.viewDidLoad()

  }

  func toggleEdit() {
    editSelected = !editSelected
    tagList.setEditing(editSelected, animated: editSelected)
    displayToolBar(editSelected)

  }
  
  func displayToolBar(show:Bool) {
    if show {
      // Show
      UIView.animateWithDuration(0.3, animations: {
        let correctHeight = self.view.frame.height - 44
        let frame = self.tagDetailToolbar.frame
        self.tagDetailToolbar.frame = CGRectMake(frame.origin.x, correctHeight, frame.width, frame.height)
      })
    } else {
      // Hide
      UIView.animateWithDuration(0.3, animations: {
        let frame = self.tagDetailToolbar.frame
        self.tagDetailToolbar.frame = CGRectMake(frame.origin.x, self.view.frame.height, frame.width, frame.height)
      })
    }
  }
  
  func updateToolBar() {
    // Change the TExt Type
    if self.selectedTags.count > 0 {
      shareButton.title = "Share"
      deleteButton.title = "Delete"
    } else {
      shareButton.title = "Share All"
      deleteButton.title = "Delete All"
    }
  }

  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // 
  
  func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
    return UITableViewCellEditingStyle.Insert
  }

  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    switch editingStyle {
    case UITableViewCellEditingStyle.Insert:
      let cell =  tableView.cellForRowAtIndexPath(indexPath) as! TagTypeDetail
      if cell.selected {
        self.selectedTags.removeObject(cell.tagObj!)
        cell.setSelected(false, animated: true)
      } else {
        self.selectedTags.append(cell.tagObj!)
        cell.setSelected(true, animated: true)
      }
      updateToolBar()
    default:
      return
    }
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tagType!.tags.count
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
  }
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCellWithIdentifier("TagTypeDetail") as! TagTypeDetail
    let tag = tagType!.tags[indexPath.row]

    cell.loadTag(tag)

    return cell
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  //
  
  @IBAction func sharePressed(sender: AnyObject) {
    if selectedTags.count > 0 {
      let texts = selectedTags.map({
        $0.shareText
      })
      let item = NSArray(array: texts).componentsJoinedByString("\n\n")
      shareTextImageAndURL(item)
    } else {
      let texts = tagType!.tags.map({
        $0.shareText
      })
      let item = NSArray(array: texts).componentsJoinedByString("\n\n")
      shareTextImageAndURL(item)
    }
  }
  
  @IBAction func deletePressed(sender: AnyObject) {
    let control = UIAlertController(title: "Are You Sure?", message: "Delete?", preferredStyle: UIAlertControllerStyle.Alert)
    let delete = UIAlertAction(title: "DELETE", style: UIAlertActionStyle.Destructive, handler: {
      finished in
      if self.selectedTags.count == 0 {
        self.tagViewModel?.deleteTags(self.tagType!)
      } else {
        _ = self.selectedTags.map({
          self.tagViewModel?.deleteTag($0)
        })
      }
      self.tagList.reloadData()
    })
    let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
    control.addAction(delete)
    control.addAction(ok)
    self.presentViewController(control, animated: true, completion: nil)

  }
  
}
