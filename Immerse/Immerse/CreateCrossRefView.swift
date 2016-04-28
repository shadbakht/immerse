//
//  CreateCrossRefView.swift
//  Immerse
//
//  Created by James Tan on 4/26/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class CreateCrossRefView: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet var secondWritingReader: UITableView!
  @IBOutlet var selectedWriting: UILabel!
  @IBOutlet var bookPickerButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
  //
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 100
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "")
    return cell
  }
  
  //
  
  @IBAction func dismiss(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: {
    })
  }
  
  @IBAction func createCrossReference(sender: AnyObject) {
    dismiss(self.view)
  }
  
  @IBAction func launchBookPicker(sender: AnyObject) {
    let colors = [["Faith","Jewish","Islam","Baha'i", "Confucious", "Socialist"], ["Book","doiawjdawojdiojawiod"]]
    let action = ActionSheetMultipleStringPicker(title: "MANY", rows: colors, initialSelection: [0,0], doneBlock: {
      finished in
      }, cancelBlock: {
        finished in
      }, origin: self.view)
    action.showActionSheetPicker()
  }
  
  @IBAction func launchSectionPicker(sender: AnyObject) {
    let colors = [["Chapter","1","2","3", "4"], ["Section","1"]]
    let action = ActionSheetMultipleStringPicker(title: "MANY", rows: colors, initialSelection: [0,0], doneBlock: {
      finished in
      }, cancelBlock: {
        finished in
      }, origin: self.view)
    action.showActionSheetPicker()

  }
  
}
