//
//  CreateNoteView.swift
//  Immerse
//
//  Created by James Tan on 4/26/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import UIKit

class CreateNoteView: UIViewController, UITextViewDelegate {

  var record : Record? = nil
  var range : NSRange? = nil
  var noteViewModel : NoteViewModel? = nil
  
  @IBOutlet var textView: UITextView!
  @IBOutlet var recordTextLabel: UILabel!
  
  override func viewDidLoad() {
    
    // Populate With the Highlighted Text
    let recordText = record!.record_text as NSString
    let result = recordText.substringWithRange(range!)
    recordTextLabel.text = result
    
    // Create the Model
    noteViewModel = NoteViewModel(viewController: self)
    noteViewModel?.setup()
    
    // Delegates
    textView.delegate = self
    
    super.viewDidLoad()

  }
  
  override func viewDidAppear(animated: Bool) {
    textView.becomeFirstResponder()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  @IBAction func createNote(sender: AnyObject) {
    noteViewModel?.createNote(record!, range: range!, text: textView.text)
    self.dismissViewControllerAnimated(true, completion: {
      
    })
  }
  
  func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    if (text == "\n") {
      noteViewModel?.createNote(record!, range: self.range!, text: textView.text)
      textView.resignFirstResponder()
      dismiss(self)
    }
    return true
  }
  
  @IBAction func dismiss(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: {
    })
  }

}
