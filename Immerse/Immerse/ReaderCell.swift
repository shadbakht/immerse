//
//  ReaderCell.swift
//  Immerse
//
//  Created by James Tan on 4/23/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import UIKit

class ReaderCell: UITableViewCell, UITextViewDelegate {

  @IBOutlet var textView: UITextView!
  var record : Record? = nil
  var hasSelected : Bool {
    get {
      return (textView.selectedTextRange?.empty)!
    }
  }
  
  var rowHeight : CGFloat {
    get {
      return textView.frame.height
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    textView.delegate = self
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
  }
  
  func textViewDidChange(textView: UITextView) {
    
    // Resize the textView
    let fixedWidth = textView.frame.size.width
    textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
    let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
    var newFrame = textView.frame
    newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
    textView.frame = newFrame;
    
  }
  
  func getSelectedText() -> (UITextRange, Record)? {
    if let range = textView.selectedTextRange, let record = record {
      return (range, record)
    }
    return nil
  }
  

}
