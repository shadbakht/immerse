//
//  NotesService.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

class NotesService: NSObject {

  class func getNotes() -> NSArray {
    return RealmService.allObjectsForType(Note.self)
  }
  
  class func getNotesForText(currentWriting:Writing) -> NSArray {
    let writing_id = currentWriting.writing_id
    let results = RealmService.objectsForQuery(Note.self, query: "writing_id = '" + writing_id + "'")
    return results
  }
  
  class func createNoteForText(start:Int, length:Int, text:String, currentWriting:Writing) {
    
    let writing_id = currentWriting.writing_id
    let notes_uid = Util.uniqueString()
    
    let newNote = Note()
    newNote.note_id = notes_uid
    newNote.writing_id = writing_id
    newNote.note_comment = text
    newNote.creation_date = NSDate()
    newNote.start_position = start
    newNote.length = length
    
    RealmService.createObject(newNote)
    
  }
}
