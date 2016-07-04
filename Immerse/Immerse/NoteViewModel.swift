//
//  NoteViewModel.swift
//  Immerse
//
//  Created by James Tan on 4/10/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import UIKit

class NoteViewModel: GenericViewModel, ViewModelProtocol {

  var notes : [Note]? = nil
  
  func setup() {
    notes = NoteInterface.getAllNotes().sort({
      return($0.0.creation_date.timeIntervalSince1970 < $0.1.creation_date.timeIntervalSince1970)
    })
  }
  
  func createNote(record:Record, range:NSRange, text:String) {
    NoteInterface.createNote(record, range:range, text:text)
  }
  
  func updateNoteText(note:Note, text:String) {
    NoteInterface.updateNote(note, text:text)
  }
  func deleteNote(note:Note) {
    NoteInterface.deleteNote(note)
  }
  func deleteAllNotes() {
    NoteInterface.deleteAllNotes()
  }

}
