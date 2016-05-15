//
//  CreateCrossRefView.swift
//  Immerse
//
//  Created by James Tan on 4/26/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class CreateCrossRefView: UIViewController, UITableViewDelegate, UITableViewDataSource, ReaderCellDelegate {

  @IBOutlet var secondWritingReader: UITableView!
  @IBOutlet var selectedWriting: UILabel!
  @IBOutlet var bookPickerButton: UIButton!
  
  var faithViewModel : FaithViewModel? = nil
  var crossRefViewModel : CrossRefViewModel? = nil
  
  var record : Record? = nil
  var range : NSRange? = nil
  
  private var selectedFaith : Faith? = nil
  private var selectedBook : Book? = nil
  private var selectedBookRecords : [Record]? = nil
  private var selectedRecord : Record? = nil
  private var selectedRange : NSRange? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setup ViewModels
    faithViewModel = FaithViewModel(viewController: self)
    faithViewModel?.setup()
    
    crossRefViewModel = CrossRefViewModel(viewController: self)
    crossRefViewModel?.setup()
    
    // Populate Text
    let text = (record!.record_text as NSString).substringWithRange(range!)
    selectedWriting.text = text
    
    // Set the Table Delegates
    secondWritingReader.delegate = self
    secondWritingReader.dataSource = self
    let nib = UINib(nibName: "ReaderCell", bundle: nil)
    secondWritingReader.registerNib(nib, forCellReuseIdentifier: "ReaderCell")

    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
  //
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if self.selectedBookRecords != nil {
      return self.selectedBookRecords!.count
    } else {
      return 0
    }
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if self.selectedBookRecords != nil {
      let record = self.selectedBookRecords![indexPath.row]
      let cell = tableView.dequeueReusableCellWithIdentifier("ReaderCell") as! ReaderCell
      cell.delegate = self
      cell.loadRecord(record)
      return cell
    } else {
      return UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "")
    }
  }
  
  func getTextSizeMultiplier() -> CGFloat {
    return 1.0
  }
  func getTextColor() -> UIColor {
    return UIColor.darkGrayColor()
  }
  func getBackgroundColor() -> UIColor {
    return UIColor.clearColor()
  }
  func textWasSelected(range: NSRange?, record: Record?) {
    selectedRange = range
    selectedRecord = record
  }

  //
  
  @IBAction func dismiss(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: {
    })
  }
  
  @IBAction func createCrossReference(sender: AnyObject) {
    crossRefViewModel!.createCrossReference(
      record!, sourceRange: range!,
      destinationRecord: selectedRecord!, destinationRange: selectedRange!
    )
    dismiss(self.view)
  }
  
  @IBAction func launchFaithSelect(sender: AnyObject) {
    let names = faithViewModel?.faiths.map({$0.name})
    let action = ActionSheetStringPicker(
      title: "Select a Faith",
      rows: names,
      initialSelection: 0,
      doneBlock:{
        finished in
        let index = finished.1
        self.selectedFaith = self.faithViewModel?.faiths[index]
      },
      cancelBlock: {
        finished in
      }, origin: self.view)
    action.showActionSheetPicker()
  }
  
  @IBAction func launchBookSelect(sender: AnyObject) {
    if (selectedFaith) != nil {
      let books = selectedFaith!.books.map({$0.name})
      let action = ActionSheetStringPicker(
        title: "Select a Faith",
        rows: books,
        initialSelection: 0,
        doneBlock:{
          finished in
          let index = finished.1
          self.selectedBook = self.selectedFaith!.books[index]
          
          // Populate the Reader View
          self.selectedBookRecords = self.selectedBook?.records
          self.secondWritingReader.reloadData()
        },
        cancelBlock: {
          finished in
        }, origin: self.view)
      action.showActionSheetPicker()
    }
  }
  
  @IBAction func launchChapterSelect(sender: AnyObject) {
  }
  
}
