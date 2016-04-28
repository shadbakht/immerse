//
//  TagTypeDetail.swift
//  Immerse
//
//  Created by James Tan on 4/28/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import UIKit

class TagTypeDetail: UITableViewCell {

  @IBOutlet var taggedText: UITextView!
  @IBOutlet var tagLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
      // Initialization code
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  func loadTag(tag:Tag) {
    
    let faith = tag.record!.faith!.name
    let author = tag.record!.author!.name
    let book = tag.record!.book!.name
    let title = "\(faith) - \(author) - \(book)"
    tagLabel.text = title
    
    //
    
    let recordString = (tag.record!.record_text as NSString).substringWithRange(NSMakeRange(tag.start_position, tag.length))
    taggedText.text = recordString
  }
}
