//
//  RefCell.swift
//  Immerse
//
//  Created by James Tan on 1/9/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import UIKit

class RefCell: UITableViewCell {

  @IBOutlet weak var numberOfReferences: UIImageView!
  @IBOutlet weak var selectionButton: UIImageView!
  
  @IBOutlet weak var sourceWritingName: UILabel!
  @IBOutlet weak var referenceWritingName: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  func load(obj:NSObject) {
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

  }
  
}
