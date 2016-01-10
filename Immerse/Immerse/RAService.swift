//
//  RAService.swift
//  Immerse
//
//  Created by James Tan on 11/10/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

class RAService: NSObject {
  static var mapping : NSArray = [] // Publicly Accessible Mappings - Text
  static var tagMapping : NSArray = [] // Publicly Accessible Mappings - Tags
  static var noteMapping : NSArray = []
  
  class func recursivelyBuildXRefMapping() {
    let allRefs : [CrossRef] = CrossRefService.getRefs() as! [CrossRef]
    let objects : [RAObject] = []
    for ref in allRefs {
      let object = RAObject()
      ref.sta
    }
  }
  
  class func recursivelyBuildNoteMapping() {
    let allNotes : [Note] = NotesService.getNotes() as! [Note]
    var objects : [RAObject] = []
    for note in allNotes {
      
      let object = RAObject()
      object.displayName = note.note_comment
      object.id = note.note_id
      
      // Fetch the note's associated writing object
      let writingID = note.writing_id
      let writing = WritingService.writingForID(writingID)
      let writingObject = RAObject()
      writingObject.displayName = writing!.writing_title
      writingObject.id  = writingID
      
      // Get the Substring text
      let start = note.start_position
      let length = note.length
      let subString = WritingService.getBodyForWriting(writing!, start: start, length: length)
      object.subDisplayName = subString

      
      let existing = objects.filter({ $0.id == writingID })
      if existing.count > 0 {
        existing.first?.addChild(object)
      } else {
        writingObject.addChild(object)
        objects.append(writingObject)
      }
    }
    RAService.noteMapping = objects
  }
  
  class func recursivelyBuildTagMapping() {
    /**
     recursivelyBuildTagMapping
     Current only supports level 1 tags and not anything more.
     */
    let allTags : [TagTypes] = TagService.getTagTypes() as! [TagTypes]
    var objects : [RAObject] = []
    for tag in allTags {
      let object = RAObject()
      object.displayName = tag.tag_type_name
      object.id = tag.tag_type_id
      
      // Fetch the tag + associated writing object
      var children : [RAObject] = []
      let results : [Tag] = RealmService.objectsForQuery(Tag.self, query: "tag_type_id = '\(tag.tag_type_id)'") as! [Tag]
      for item:Tag in results {
        // Retrieve the data to populate for the tag
        let writingId = item.writing_id
        let start = item.start_position
        let length = item.length
        if let writing = WritingService.writingForID(writingId) {
          let writingName = writing.writing_title
          let subString = WritingService.getBodyForWriting(writing, start: start, length: length)
          let child = RAObject()
          child.displayName = subString
          child.id = writingId
          child.subDisplayName = writingName
          children.append(child)
        }
        object.children = children
      }
      objects.append(object)
    }
    RAService.tagMapping = objects
  }
  
  class func recursivelyBuildMapping(mapType:AnnotationType? = nil) {
    /**
     recursivelyBuildMapping
     Maps out the complete structure of the resourcePath for the bundle, then selects
     only those parent levels whose names match those found RAService.folderNames
     */
    
    let path = NSBundle.mainBundle().resourcePath!
    let enumerator = NSFileManager.defaultManager().enumeratorAtPath(path)
    
    var parent : RAObject? = nil
    var parentName : String? = nil
    var lastFolder : RAObject? = nil
    let folderCollections : NSMutableArray = []
    
    
    while let filePath = enumerator?.nextObject() as? String {
    
      let lastItem = filePath.componentsSeparatedByString("/").last
      let itemCount = filePath.componentsSeparatedByString("/").count
      
      if lastItem != nil {
        
        if itemCount == 1 && !lastItem!.hasSuffix(".txt") {
          if lastItem != parentName && parentName != nil{
            // Add the parent to the collection
            // This condition tests that our parent in examination has changed
            // The previous parent is deemed complete
            folderCollections.addObject(parent!)
          }
          parentName = lastItem
          parent = createFolder(lastItem!, path: lastItem!)
          lastFolder = parent
          continue
        }
        
        if !lastItem!.hasSuffix(".txt") {
          let folder = createFolder(lastItem!, path: lastItem!)
          
          if (itemCount >= 3)  {
            lastFolder?.addChild(folder)
          } else {
            parent?.addChild(folder)
          }
          
          lastFolder = folder
          continue
        }
        
        if lastItem!.hasSuffix(".txt") {
          // The enumerator drills down a folder before across. So we know with good certainty that the .txt
          // of interest lies at theend of the tree, so we can just add them to the latest parent child.
          // Can also add writings to the parent if there are no children nodes
          let file = createWriting(lastItem!)
          lastFolder?.addChild(file)
          
          // Depending on the mode of this execution, add or remove additional nodes for the text pertaining
          // the writings.
          if mapType != nil {
            switch mapType! {
            case AnnotationType.Note:
              let note = createWriting("")
              file.addChild(note)
            case AnnotationType.Tag:
              let note = createWriting("")
              file.addChild(note)
            case AnnotationType.Ref:
              let ref = createWriting("")
              file.addChild(ref)
            }
          }
          
          continue
        }
      }
      
    }
    
    // Cut off the top, those are the folders of interest.
    // Otherwise we'll get everything in the bundle.
    let finalSet : NSMutableArray = []
    for parent in folderCollections {
      let parentObj = parent as! RAObject
      if Constants.folderNames.containsObject(parentObj.pathName) {
        finalSet.addObject(parent)
      }
    }
    RAService.mapping = finalSet.copy() as! NSArray
    
  }
  
  private class func createFolder(display:String, path:String, children:NSArray = [] ) -> RAObject {
    let object = RAObject()
    
    object.configure(display, pathName: path, children: children as! [RAObject])
    return object
  }
  private class func createWriting(name:String) -> RAObject {
    let object = RAObject()
    object.configure(name.stringByReplacingOccurrencesOfString(".txt", withString: ""),
      pathName: name,
      children: [])
    return object
  }
  private class func setChildren() -> RAObject {
    let object = RAObject()
    return object
  }
}
