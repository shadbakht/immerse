//
//  NotesView.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
import KYDrawerController

class NotesView: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet var notesTableView: UITableView!
  private var sorting : SortOption = SortOption.None
  private var uniqueBooks : [Book] = []
  private var uniqueAuthors : [Author] = []
  var noteViewModel : NoteViewModel? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    noteViewModel = NoteViewModel(viewController: self)
    noteViewModel?.setup()
    
    notesTableView.delegate = self
    notesTableView.dataSource = self
    
    let nib = UINib(nibName: "NotesCell", bundle: nil)
    notesTableView.registerNib(nib, forCellReuseIdentifier: "NotesCell")
    notesTableView.tableFooterView = UIView(frame: CGRectZero)

  }

  //
  
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
      let sectionBooks = self.noteViewModel!.notes!.filter({
        return ($0.record!.book!.isEqual(book))
      })
      return sectionBooks.count
    case SortOption.AuthorAlphabetical:
      let author = self.uniqueAuthors[section]
      let sectionAuthor = self.noteViewModel!.notes!.filter({
        return ($0.record!.author!.isEqual(author))
      })
      return sectionAuthor.count
    default:
      return noteViewModel!.notes!.count
    }
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("NotesCell") as! NotesCell
    
    switch sorting {
    case SortOption.BookAlphabetical:
      let book = self.uniqueBooks[indexPath.section]
      let sectionBooks = self.noteViewModel!.notes!.filter({
        ($0.record!.book == book)
      })
      let refs = sectionBooks[indexPath.row]
      cell.loadNote(refs)
    case SortOption.AuthorAlphabetical:
      let author = self.uniqueAuthors[indexPath.section]
      let sectionAuthors = self.noteViewModel!.notes!.filter({
        ($0.record!.author == author)
      })
      let refs = sectionAuthors[indexPath.row]
      cell.loadNote(refs)
    default:
      let cross = noteViewModel!.notes![indexPath.row]
      cell.loadNote(cross)
    }
    
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

  //
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func menuOpen(sender: UIBarButtonItem) {
    if let drawerController = navigationController?.parentViewController as? KYDrawerController {
      drawerController.setDrawerState(.Opened, animated: true)
    }
  }
  
  
  @IBAction func showSortingOptions(sender: AnyObject) {
    let alert = UIAlertController(title: "Group Cross References By", message: "Select a dimension to group your cross references along.", preferredStyle: .ActionSheet)
    
    let firstAction = UIAlertAction(title: "Writing [A-Z]", style: .Default) { (alert: UIAlertAction!) -> Void in
      self.sorting = SortOption.BookAlphabetical
      
      // Sort the Books
      let books = self.noteViewModel!.notes!.map({$0.record!.book!})
      self.uniqueBooks = NSSet(array: books).allObjects as! [Book]
      self.notesTableView.reloadData()
    }
    
    let secondAction = UIAlertAction(title: "Author [A-Z]", style: .Default) { (alert: UIAlertAction!) -> Void in
      self.sorting = SortOption.AuthorAlphabetical
      
      // Sort the Authors
      let authors = self.noteViewModel!.notes!.map({$0.record!.author!})
      self.uniqueAuthors = NSSet(array: authors).allObjects as! [Author]
      self.notesTableView.reloadData()
    }
    
    
    let thirdAction = UIAlertAction(title: "Recent", style: .Default) { (alert: UIAlertAction!) -> Void in
      self.sorting = SortOption.BookRecent
      self.notesTableView.reloadData()
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


}
