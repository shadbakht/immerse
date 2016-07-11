//
//  NoteDetailView.swift
//  Immerse
//
//  Created by James Tan on 5/14/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import UIKit

class NoteDetailView: UIViewController {

  var note : Note? = nil
  private var notesViewModel : NoteViewModel? = nil
  
  
  @IBOutlet weak var labelText: UILabel!
  @IBOutlet weak var labelAuthor: UILabel!
  @IBOutlet weak var textViewSource: UITextView!
  @IBOutlet weak var textViewNote: UITextView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    notesViewModel = NoteViewModel(viewController: self)
    
    if let n = note {
      labelText.text = n.record?.book?.name
      labelAuthor.text = n.record?.author?.name
      textViewSource.text = n.recordText
      textViewNote.text = n.note_comment
    }
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func sharePressed(sender: UIBarButtonItem) {
    let noteShareText = "NOTE: \(note!.note_comment)\n" + "FROM: \(note!.creation_date)\n" + "\((note!.record!.record_text as NSString).substringWithRange(NSMakeRange(note!.start_position, note!.length)))\n\n"
    shareTextImageAndURL(noteShareText)

  }
  
  @IBAction func editPressed(sender: UIBarButtonItem) {
    textViewNote.editable = !textViewNote.editable
    if textViewNote.editable {
      sender.title = "Save"
      textViewNote.becomeFirstResponder()
    } else {
      notesViewModel?.updateNoteText(note!, text: textViewNote.text)
      sender.title = "Edit"
      textViewNote.resignFirstResponder()
    }
  }
  
  @IBAction func deletePressed(sender: UIBarButtonItem) {
    let control = UIAlertController(title: "Are You Sure?", message: "Once you delete, you cannot get it back. Are you sure?", preferredStyle: UIAlertControllerStyle.Alert)
    let delete = UIAlertAction(title: "DELETE", style: UIAlertActionStyle.Destructive, handler: {
      finished in
      
      self.notesViewModel?.deleteNote(self.note!)
      self.navigationController?.popViewControllerAnimated(true)
    })
    let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
    control.addAction(ok)
    control.addAction(delete)
    self.presentViewController(control, animated: true, completion: nil)
  }
  
}
