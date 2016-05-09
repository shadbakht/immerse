//
//  NotesCell.swift
//  Immerse
//
//  Created by James Tan on 4/28/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import UIKit

class NotesCell: UITableViewCell, UITextViewDelegate {

  @IBOutlet var noteLabel: UILabel!
  @IBOutlet var noteBody: UITextView!
  @IBOutlet var recordBody: UITextView!
  var note : Note? = nil
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    noteBody.delegate = self
    recordBody.delegate = self
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  func loadNote(note:Note) {
    self.note = note
    
    let faith = note.record!.faith!.name
    let book = note.record!.book!.name
    let author = note.record!.author!.name
    let title = "\(faith) - \(book) - \(author)"
    
    noteLabel.text = title
    
    ///
    
    let noteSubString = (note.record!.record_text as NSString).substringWithRange(NSMakeRange(note.start_position, note.length))
    let noteComment = note.note_comment
    
    recordBody.text = noteSubString
    noteBody.text = noteComment
  }
  
  func textViewDidChange(textView: UITextView) {
    let fixedWidth = textView.frame.size.width
    textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
    let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
    var newFrame = textView.frame
    newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
    textView.frame = newFrame
  }

}
