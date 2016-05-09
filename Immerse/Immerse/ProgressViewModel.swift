//
//  ProgressViewModel.swift
//  Immerse
//
//  Created by James Tan on 5/8/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import UIKit

class ProgressViewModel: GenericViewModel, ViewModelProtocol {

  var progress : [Progress] = []
  
  func setup() {
    progress = ProgressInterface.getAllProgress()
  }
  
  func getProgress(writing:Book) -> Progress {
    let progress = ProgressInterface.getProgress(writing)
    if progress == nil {
      createProgress(writing.records.first!, row: 0)
    }
    return ProgressInterface.getProgress(writing)!
  }
  
  func createProgress(record:Record, row: Int) {
    let book = record.book!
    ProgressInterface.createProgress(book, index: row)
  }
  
}
