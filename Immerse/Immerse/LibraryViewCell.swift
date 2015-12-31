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
  
  func configure(level:Int, data:RAObject) {
    
    let name = data.displayName
    let path = data.pathName
    
    if level == 0 {
      self.indentBar.alpha = 0.0
      self.title.textColor = UIColor(red: 42/255, green: 42/255, blue: 42/255, alpha: 1.0)
      self.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    } else if level >= 1 && !path.containsString(".txt")   {
      self.indentBar.alpha = 1.0
      self.title.textColor = UIColor(red: 42/255, green: 42/255, blue: 42/255, alpha: 1.0)
      self.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
    }
    if path.containsString(".txt") {
      self.indentBar.alpha = 1.0
      self.title.textColor = UIColor(red: 93/255, green: 120/255, blue: 137/255, alpha: 1.0)
      self.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
    }
    
    title.text = name
    let leftIndent = CGFloat(11 + 10.0 * Float(level))
    constraint.constant = leftIndent
    
  }
}

