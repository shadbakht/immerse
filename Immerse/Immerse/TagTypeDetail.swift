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
  var tagObj : Tag? = nil
  
  override func awakeFromNib() {
    super.awakeFromNib()
      // Initialization code
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  func loadTag(tag:Tag) {
    self.tagObj = tag
    let faith = tag.record!.faith!.name
    let author = tag.record!.author!.name
    let book = tag.record!.book!.name
    let title = "\(faith) - \(author) - \(book)"
    tagLabel.text = title
    
    //
    
    let recordString = (tag.record!.record_text as NSString).substringWithRange(NSMakeRange(tag.start_position, tag.length))
    taggedText.text = recordString
  }
  
  func textViewDidChange(textView: UITextView) {
    let fixedWidth = textView.frame.size.width
    textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
    let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
    var newFrame = textView.frame
    newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
    textView.frame = newFrame
  }
  

}
