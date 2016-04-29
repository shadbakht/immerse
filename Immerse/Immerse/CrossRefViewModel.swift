//
//  CrossRefViewModel.swift
//  Immerse
//
//  Created by James Tan on 4/10/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import UIKit

class CrossRefViewModel: GenericViewModel, ViewModelProtocol {

  var crossRefs : [CrossRef]? = nil
  func setup() {
    
  }
  
  func createCrossReference(sourceRecord:Record, sourceRange: NSRange, destinationRecord:Record, destinationRange:NSRange) {
    CrossRefInterface.createCrossRef(sourceRecord, srcRange: sourceRange, dest: destinationRecord, destRange: destinationRange)
  }
}
