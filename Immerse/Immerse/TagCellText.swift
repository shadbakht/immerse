//
//  TagCellText.swift
//  Immerse
//
//  Created by James Tan on 12/31/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

class TagCellText: UITableViewCell {

  @IBOutlet weak var indentationWidthConstraint: NSLayoutConstraint!
  @IBOutlet weak var indentationView: UIView!
  @IBOutlet weak var textWritingLabel: UILabel!
  @IBOutlet weak var textBodyLabel: UITextField!
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func set(display:String, level:Int?=nil, id:String?=nil, location:String?=nil) {
    textBodyLabel.text = display
    textWritingLabel.text = location!
  }
}
