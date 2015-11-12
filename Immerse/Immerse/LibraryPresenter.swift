//
//  LibraryPresenter.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
import RATreeView

class LibraryPresenter: NSObject {

  static let sharedInstance : LibraryPresenter = LibraryPresenter()
  var view : LibraryView? = nil
  var interactor : LibraryInteractor? = nil
  
  var isSetup : Bool = false
  var mapping : NSArray = []
  var folder : NSDictionary = [:]
  
  func setup() {
    if !isSetup {
      mapping = interactor!.loadFolderMappings()
      isSetup = true
    }
  }
}