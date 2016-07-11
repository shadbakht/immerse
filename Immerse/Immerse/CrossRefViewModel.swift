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
    crossRefs = CrossRefInterface.getAllCrossRefs().sort({
      return($0.0.creation_date.timeIntervalSince1970 < $0.1.creation_date.timeIntervalSince1970)
    })
  }
  
  func createCrossReference(sourceRecord:Record, sourceRange: NSRange, destinationRecord:Record, destinationRange:NSRange) {
    CrossRefInterface.createCrossRef(sourceRecord, srcRange: sourceRange, dest: destinationRecord, destRange: destinationRange)
  }
  
  func deleteCrossRef(crossRef:CrossRef?=nil) {
    if crossRef == nil {
      CrossRefInterface.deleteAllCrossRef()
    } else {
      CrossRefInterface.deleteCrossRef(crossRef!)
    }
  }
}
