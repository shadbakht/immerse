//
//  ReaderView.swift
//  Immerse
//
//  Created by James Tan on 4/15/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class ReaderView: UIViewController , UITableViewDataSource, UITableViewDelegate, ReaderCellDelegate  {

  @IBOutlet var navbar: UINavigationBar!
  @IBOutlet var toolbar: UIToolbar!
  @IBOutlet var settingsToolBar: UIView!
  @IBOutlet var readerTable: UITableView!
  
  
  @IBOutlet weak var settingSize: UISlider!
  @IBOutlet weak var settingTheme: UISegmentedControl!
  
  private var book : Book? = nil
  private var records : [Record]? = nil
  private var hidden : Bool = false
  private var settingsHidden : Bool = true
  private var selectedRecord : Record? = nil
  private var selectedRange : NSRange? = nil
  private var progressViewModel : ProgressViewModel? = nil
  
  // Set the Color Themes
  private let multiplierTextSizes : [(String, CGFloat)] = [
    ("Small",0.7), ("Normal", 1.0), ("Large",1.5), ("Larger",2.0), ("Largest", 4.0)]
  private let textBackgroundColors = [
    ("Regular",UIColor.blackColor(), UIColor.whiteColor()),
    ("Midnight",UIColor.whiteColor(), UIColor.blackColor()),
    ("Sepia",UIColor.rgb(68, g: 68, b: 68), UIColor.rgb(246, g: 239, b: 220))
  ]
  private var selectedTextSize : (String, CGFloat) = ("Normal", 1.0)
  private var selectedColor : (String, UIColor, UIColor) =
    ("Regular",UIColor.blackColor(), UIColor.whiteColor())

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setup Reader Settings
    if let theme = UserService.fetchValue(DefaultKey.ReaderTheme) as? String,
      let size = UserService.fetchValue(DefaultKey.ReaderSize) as? String
    {
      configureReader(theme, size:size)
    } else {
      UserService.setValue(DefaultKey.ReaderTheme, value: "Regular")
      UserService.setValue(DefaultKey.ReaderSize, value: "Normal")
      configureReader("Regular", size: "Normal")
    }

    // Setup the Reader
    let nib = UINib(nibName: "ReaderCell", bundle: nil)
    readerTable.registerNib(nib, forCellReuseIdentifier: "ReaderCell")
    readerTable.delegate = self
    readerTable.dataSource = self

    // Setup the Toggle
    let tap = UITapGestureRecognizer(target: self, action: #selector(toggleTools))
    tap.numberOfTapsRequired = 1
    readerTable.addGestureRecognizer(tap)
    
    // Setup Progress
    progressViewModel = ProgressViewModel(viewController: self)
    progressViewModel?.setup()
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func viewWillAppear(animated: Bool) {
    
    // Reload the Progress
    let progress = progressViewModel!.getProgress(book!)
    let indexPath = NSIndexPath(forRow: progress.row, inSection: 0)
    self.readerTable.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: false)
  }
  
  func load(book:Book) {
    self.book = book
    records = book.records
  }
  
  func toggleTools(hide:Bool=false) {
    // hide will try to override whateve
    if (hidden && !hide) {
      // Show
      hidden = false
      UIView.animateWithDuration(0.3, animations: {
        self.navbar.frame.setY(0)
        self.toolbar.frame.setY(self.readerTable.frame.height-self.toolbar.frame.height)
      })
    } else {
      // Hide
      hidden = true
      UIView.animateWithDuration(0.3, animations: {
        self.navbar.frame.setY(-self.navbar.frame.height)
        self.toolbar.frame.setY(self.readerTable.frame.height)
      })
      if (!settingsHidden) {
        toggleSettings()
      }
    }
  }
  
  func toggleSettings() {
    if (settingsHidden) {
      settingsHidden = false
      UIView.animateWithDuration(0.3, animations: {
        self.settingsToolBar.frame.setY(44)
        self.settingsToolBar.alpha = 1.0
      })
    } else {
      settingsHidden = true
      UIView.animateWithDuration(0.3, animations: {
        self.settingsToolBar.frame.setY(-132)
        self.settingsToolBar.alpha = 0.0
      })

    }
  }
  
  func configureReader(value:String, size:String) {
    let chosenTheme = textBackgroundColors.filter({$0.0 == value})
    let chosenSize = multiplierTextSizes.filter({$0.0 == size})
    if let theme = chosenTheme.first, let size = chosenSize.first {
      if let indexTheme = textBackgroundColors.indexOf({
        $0.0 == theme.0
      }) {
        settingTheme.selectedSegmentIndex = indexTheme
      }
      if let indexSize = multiplierTextSizes.indexOf({
        $0.0 == size.0
      }) {
        settingSize.value = Float(indexSize.successor()-1)
      }
      
      selectedColor = theme
      selectedTextSize = size
    }
  }

  
  @IBAction func close(sender: UIBarButtonItem) {
    self.dismissViewControllerAnimated(true, completion: {
    })
  }
  
  // MARK:-SCROLL PROTOCOL
  
  func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    print("Stopped Moving")
    toggleTools(true)
    
    let cell = readerTable.visibleCells.last as! ReaderCell
    let record = cell.record
    let indexPath = readerTable.indexPathForCell(cell)
    progressViewModel!.createProgress(record!, row: indexPath!.row)
    
    // Update Progress View
    let progress = progressViewModel!.getProgress(book!).percent
    print(progress)
  }
  
  func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    print("Stopped Dragging")
    if !decelerate {
      toggleTools(true)

      let cell = readerTable.visibleCells.last as! ReaderCell
      let record = cell.record
      let indexPath = readerTable.indexPathForCell(cell)
      progressViewModel!.createProgress(record!, row: indexPath!.row)
      
      // Update Progress View
      let progress = progressViewModel!.getProgress(book!).percent
      print(progress)
    }
  }
  
  // MARK:-PROTOCOLS
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let count = records?.count {
      return count
    }
    return 0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let record = records![indexPath.row]
    let cell = tableView.dequeueReusableCellWithIdentifier("ReaderCell") as! ReaderCell
    cell.delegate = self
    cell.loadRecord(record)
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func getTextColor() -> UIColor {
    return selectedColor.1
  }
  
  func getTextSizeMultiplier() -> CGFloat {
    return selectedTextSize.1
  }
  
  func getBackgroundColor() -> UIColor {
    return selectedColor.2
  }
  
  func textWasSelected(range: NSRange?, record: Record?) {
    selectedRange = range
    selectedRecord = record
    if (hidden) {
      toggleTools()
    }
  }
  
  // MARK:-TOOLBAR
  
  @IBAction func textColorSelected(sender: UISegmentedControl) {
    let index = sender.selectedSegmentIndex
    selectedColor = textBackgroundColors[index]
    UserService.setValue(DefaultKey.ReaderTheme, value: selectedColor.0)
    readerTable.reloadData()
  }
  
  @IBAction func textSizeChanged(sender: UISlider) {
    if sender.value < 0.5 {
      sender.value = 0
    } else if (0.5 < sender.value && sender.value < 1.5) {
      sender.value = 1
    } else if (1.5 < sender.value && sender.value < 2.5) {
      sender.value = 2
    } else if (2.5 < sender.value && sender.value < 3.5) {
      sender.value = 3
    } else {
      sender.value = 4
    }
    selectedTextSize = multiplierTextSizes[Int(sender.value)]
    UserService.setValue(DefaultKey.ReaderSize, value: selectedTextSize.0)
    readerTable.reloadData()
  }
  
  @IBAction func showSettings(sender: AnyObject) {
    toggleSettings()
  }
  
  @IBAction func showTableOfContents(sender: AnyObject) {
    let chapterHeaders = self.records?.filter({$0.record_type == "chapter"})
    let chapterNames = chapterHeaders!.map({$0.record_text})
    let action = ActionSheetStringPicker(
      title: "Select a Chapter",
      rows: chapterNames,
      initialSelection: 0,
      doneBlock:{
        finished in
        let headerIndex = finished.1
        let chapterHeader = chapterHeaders![headerIndex]
        let index = chapterHeader.record_textCount
        let indexPath = NSIndexPath(forRow: index, inSection: 0)
        self.readerTable.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Middle, animated: true)
      },
      cancelBlock: {
        finished in
      }, origin: self.view)
    action.showActionSheetPicker()
  }
  
  @IBAction func addCrossRef(sender: AnyObject) {
    if hasValues() {
      let create = CreateCrossRefView(nibName: "CreateCrossRefView", bundle: nil)
      create.record = self.selectedRecord
      create.range = self.selectedRange
      self.presentViewController(create, animated: true, completion: nil)
    }
  }
  
  @IBAction func addNote(sender: AnyObject) {
    if hasValues() {
      let create = CreateNoteView(nibName: "CreateNoteView", bundle: nil)
      create.record = self.selectedRecord
      create.range = self.selectedRange
      self.presentViewController(create, animated: true, completion: nil)
    }
  }
  
  @IBAction func addTag(sender: AnyObject) {
    if hasValues() {
      let create = CreateTagView(nibName: "CreateTagView", bundle: nil)
      create.record = self.selectedRecord
      create.range = self.selectedRange
      self.presentViewController(create, animated: true, completion: nil)
    }
  }
  
  private func hasValues() -> Bool {
    if (self.selectedRange == nil && self.selectedRecord == nil) {
      let alert = UIAlertController(title: "No Text Selected", message: "Please select some text before creating an annotation.", preferredStyle: UIAlertControllerStyle.Alert)
      let okay = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
      alert.addAction(okay)
      self.presentViewController(alert, animated: true, completion: nil)
      return false
    }
    return true
  }

}
