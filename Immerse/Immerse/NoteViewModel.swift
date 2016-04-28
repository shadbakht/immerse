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
    notes = NoteInterface.getAllNotes()
  }
  
  func createNote(record:Record, range:NSRange, text:String) {
    NoteInterface.createNote(record, range:range, text:text)
  }

}
