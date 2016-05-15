//
//  CrossRefView.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
import KYDrawerController

class CrossRefView: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var crossRefToolbar: UIToolbar!
  
  var crossRefViewModel : CrossRefViewModel? = nil
  private var sorting : SortOption = SortOption.None
  private var uniqueBooks : [Book] = []
  private var uniqueAuthors : [Author] = []
  private var selectedCrossRefs : [CrossRef] = []
  @IBOutlet var crossRefTableView: UITableView!
  @IBOutlet weak var shareButton: UIBarButtonItem!
  @IBOutlet weak var deleteButton: UIBarButtonItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setup ViewModel
    crossRefViewModel = CrossRefViewModel(viewController: self)
    crossRefViewModel?.setup()
    
    // Setup Table
    crossRefTableView.delegate = self
    crossRefTableView.dataSource = self
    let nib = UINib(nibName: "CrossRefCell", bundle: nil)
    crossRefTableView.registerNib(nib, forCellReuseIdentifier: "CrossRefCell")
    crossRefTableView.tableFooterView = UIView()

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  //
  
  func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
    return UITableViewCellEditingStyle.Insert
  }

  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    switch sorting {
    case SortOption.BookAlphabetical:
      return self.uniqueBooks.count
    case SortOption.AuthorAlphabetical:
      return self.uniqueAuthors.count
    default:
      return 1
    }
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch sorting {
    case SortOption.BookAlphabetical:
      let book = self.uniqueBooks[section]
      let sectionBooks = self.crossRefViewModel!.crossRefs!.filter({
        return ($0.source_ref!.book!.isEqual(book))
      })
      return sectionBooks.count
    case SortOption.AuthorAlphabetical:
      let author = self.uniqueAuthors[section]
      let sectionAuthor = self.crossRefViewModel!.crossRefs!.filter({
        return ($0.source_ref!.author!.isEqual(author))
      })
      return sectionAuthor.count
    default:
      return crossRefViewModel!.crossRefs!.count
    }
  }
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("CrossRefCell") as! CrossRefCell
    
    switch sorting {
    case SortOption.BookAlphabetical:
      let book = self.uniqueBooks[indexPath.section]
      let sectionBooks = self.crossRefViewModel!.crossRefs!.filter({
        ($0.source_ref!.book == book)
      })
      let refs = sectionBooks[indexPath.row]
      cell.loadCrossRef(refs)
    case SortOption.AuthorAlphabetical:
      let author = self.uniqueAuthors[indexPath.section]
      let sectionAuthors = self.crossRefViewModel!.crossRefs!.filter({
        ($0.source_ref!.author == author)
      })
      let refs = sectionAuthors[indexPath.row]
      cell.loadCrossRef(refs)
    default:
      let cross = crossRefViewModel!.crossRefs![indexPath.row]
      cell.loadCrossRef(cross)
    }
    
    return cell
  
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch sorting {
    case SortOption.BookAlphabetical:
      let book = self.uniqueBooks[section]
      return book.name
    case SortOption.AuthorAlphabetical:
      let author = self.uniqueAuthors[section]
      return author.name
    default:
      return nil
    }
  }
  
  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    switch editingStyle {
    case UITableViewCellEditingStyle.Insert:
      let cell =  tableView.cellForRowAtIndexPath(indexPath) as! CrossRefCell
      if cell.selected {
        self.selectedCrossRefs.removeObject(cell.crossRef!)
        cell.setSelected(false, animated: true)
      } else {
        self.selectedCrossRefs.append(cell.crossRef!)
        cell.setSelected(true, animated: true)
      }
      updateToolBar()
    default:
      return
    }
  }

  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let detail = CrossRefDetailView(nibName: "CrossRefDetailView", bundle: nil)
    self.showViewController(detail, sender: self)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }

  //
  
  @IBAction func menuOpen(sender: UIBarButtonItem) {
    if let drawerController = navigationController?.parentViewController as? KYDrawerController {
      drawerController.setDrawerState(.Opened, animated: true)
    }
  }
  
  @IBAction func toggleEdit(sender: UIBarButtonItem) {
    if sender.tag == 0 {
      self.crossRefTableView.setEditing(true, animated: true)
      displayToolBar(true)
      sender.tag = 1
    } else {
      self.crossRefTableView.setEditing(false, animated: true)
      displayToolBar(false)
      sender.tag = 0
    }
  }
  
  func displayToolBar(show:Bool) {
    if show {
      // Show
      UIView.animateWithDuration(0.3, animations: {
        let correctHeight = self.view.frame.height - 44
        let frame = self.crossRefToolbar.frame
        self.crossRefToolbar.frame = CGRectMake(frame.origin.x, correctHeight, frame.width, frame.height)
      })
    } else {
      // Hide
      UIView.animateWithDuration(0.3, animations: {
        let frame = self.crossRefToolbar.frame
        self.crossRefToolbar.frame = CGRectMake(frame.origin.x, self.view.frame.height, frame.width, frame.height)
      })
    }
  }
  
  @IBAction func showSortingOptions(sender: AnyObject) {
    let alert = UIAlertController(title: "Group Cross References By", message: "Select a dimension to group your cross references along.", preferredStyle: .ActionSheet)
    
    let firstAction = UIAlertAction(title: "Writing [A-Z]", style: .Default) { (alert: UIAlertAction!) -> Void in
      self.sorting = SortOption.BookAlphabetical
      
      // Sort the Books
      let books = self.crossRefViewModel!.crossRefs!.map({$0.source_ref!.book!})
      self.uniqueBooks = NSSet(array: books).allObjects as! [Book]
      self.crossRefTableView.reloadData()
    }
    
    let secondAction = UIAlertAction(title: "Author [A-Z]", style: .Default) { (alert: UIAlertAction!) -> Void in
      self.sorting = SortOption.AuthorAlphabetical
      
      // Sort the Authors
      let authors = self.crossRefViewModel!.crossRefs!.map({$0.source_ref!.author!})
      self.uniqueAuthors = NSSet(array: authors).allObjects as! [Author]
      self.crossRefTableView.reloadData()
    }
    
    
    let thirdAction = UIAlertAction(title: "Recent", style: .Default) { (alert: UIAlertAction!) -> Void in
      self.sorting = SortOption.BookRecent
      self.crossRefTableView.reloadData()
    }
    
    let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
      finished in
      
    })
    
    alert.addAction(firstAction)
    alert.addAction(secondAction)
    alert.addAction(thirdAction)
    alert.addAction(cancel)
    presentViewController(alert, animated: true, completion:nil)
    
  }
  
  @IBAction func share(sender: UIBarButtonItem) {
    // Share Button Selected
    var text : String = ""
    if selectedCrossRefs.count > 0 {
      // Selected Notes Are Shared
      let compiled = selectedCrossRefs.map({
        return "Created: \($0.creation_date) / Source Ref: \($0.source_ref!.book!.name) / Destination Ref: \($0.destination_ref!.book!.name)\n\n" +
        "Source Text: \($0.sourceText) / Destination Text: \($0.destinationText)"
      })
      text = NSArray(array: compiled).componentsJoinedByString("--------------------")
    } else {
      // All CrossRefs Are Shared
    }
    shareTextImageAndURL(text)

    crossRefTableView.setEditing(false, animated: true)
    self.selectedCrossRefs.removeAll()
    self.crossRefTableView.reloadData()
  }

  @IBAction func deleteAction(sender: UIBarButtonItem) {
  }
  
  func updateToolBar() {
    // Change the Text Type
    if self.selectedCrossRefs.count > 0 {
      shareButton.title = "Share"
      deleteButton.title = "Delete"
    } else {
      shareButton.title = "Share All"
      deleteButton.title = "Delete All"
    }
  }

  
}
