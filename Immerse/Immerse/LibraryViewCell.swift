//
//  LibraryViewCell.swift
//  Immerse
//
//  Created by James Tan on 12/31/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit


class LibraryViewCell : UITableViewCell {
  
  @IBOutlet weak var constraint: NSLayoutConstraint!
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var indentBar: UIView!
  var exists : Bool = false
  
  func configure(level:Int, data:NSObject) {
  }
}

