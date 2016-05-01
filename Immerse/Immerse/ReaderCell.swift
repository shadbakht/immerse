//
//  ReaderCell.swift
//  Immerse
//
//  Created by James Tan on 4/23/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import UIKit


protocol ReaderCellDelegate {
  func textWasSelected(range:NSRange, record:Record)
  func getTextSizeMultiplier() -> CGFloat
  func getTextColor() -> UIColor
  func getBackgroundColor() -> UIColor
}

class ReaderCell: UITableViewCell, UITextViewDelegate {

  @IBOutlet var textView: UITextView!
  var record : Record? = nil
  var delegate : ReaderCellDelegate? = nil
  
    override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    textView.delegate = self
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  

  func loadRecord(record:Record) {
    self.record = record
    textView.text = record.record_text
    
    let delegateMultiplier : CGFloat = delegate!.getTextSizeMultiplier()
    let delegateColor : UIColor = delegate!.getTextColor()
    let delegateBackgroundColor : UIColor = delegate!.getBackgroundColor()
    
    // Adjust the Font size and styling
    switch record.record_type {
    case "chapter":
      textView.font = UIFont.systemFontOfSize(20 * delegateMultiplier)
    case "section":
      textView.font = UIFont.systemFontOfSize(17 * delegateMultiplier)
    default:
      textView.font = UIFont.systemFontOfSize(13 * delegateMultiplier)
    }
    
    // Adjust the Colors
    textView.textColor = delegateColor
    textView.backgroundColor = delegateBackgroundColor
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
  
  func textViewDidChangeSelection(textView: UITextView) {
    let range = textView.selectedRange
    if range.length != 0 {
      delegate?.textWasSelected(range, record: record!)
    }
  }
}
