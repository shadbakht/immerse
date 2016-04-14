//
//  FaithViewModel.swift
//  Immerse
//
//  Created by James Tan on 4/10/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import UIKit

class FaithViewModel: GenericViewModel, ViewModelProtocol {
  
  var faiths : [Faith] = []
  
  func setup() {
    if faiths.isEmpty {
      let fetchFaiths =  Faith.getAllFaiths()
      faiths = fetchFaiths
    }
    
  }

}
