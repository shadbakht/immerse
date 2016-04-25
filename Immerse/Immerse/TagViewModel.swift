//
//  TagViewModel.swift
//  Immerse
//
//  Created by James Tan on 4/10/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import UIKit

class TagViewModel: GenericViewModel, ViewModelProtocol  {

  var tags : [Tag] = []
  var tagTypes : [TagType] = []
  
  func setup() {
    tagTypes = TagTypeInterface.getAllTagTypes()
  }
  
  func createTagType(name:String) -> Bool {
    
    TagTypeInterface.createTag(name)
    
    return true
  }
  
}
