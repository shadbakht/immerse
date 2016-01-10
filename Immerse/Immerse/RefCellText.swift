//
//  RefCellText.swift
//  Immerse
//
//  Created by James Tan on 1/9/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import UIKit

class RefCellText: UITableViewCell {

  @IBOutlet weak var sourceTitle: UILabel!
  @IBOutlet weak var sourceText: UILabel!
  
  @IBOutlet weak var refTitle: UILabel!
  @IBOutlet weak var refText: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  func load(obj:RAObjectReference) {
    sourceTitle.text = obj.displayName
    sourceText.text = obj.subDisplayName

    refTitle.text = obj.displayName2
    refText.text = obj.subDisplayName2
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
    
}
