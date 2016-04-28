//
//  NotesCell.swift
//  Immerse
//
//  Created by James Tan on 4/28/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import UIKit

class NotesCell: UITableViewCell {

  @IBOutlet var noteLabel: UILabel!
  @IBOutlet var noteTitle: UILabel!
  @IBOutlet var noteBody: UITextView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  func loadNote(note:Note) {
    
    let faith = note.record!.faith!.name
    let book = note.record!.book!.name
    let author = note.record!.author!.name
    let title = "\(faith) - \(book) - \(author)"
    
    noteLabel.text = title
    
    ///
    
    let noteSubString = (note.record!.record_text as NSString).substringWithRange(NSMakeRange(note.start_position, note.length))
    let noteComment = note.note_comment
    
    noteTitle.text = noteSubString
    noteBody.text = noteComment
  }
}
