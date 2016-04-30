//
//  CrossRefCell.swift
//  Immerse
//
//  Created by James Tan on 4/29/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import UIKit

class CrossRefCell: UITableViewCell, UITextViewDelegate {

  @IBOutlet var sourceTextView: UITextView!
  @IBOutlet var destinationTextView: UITextView!

  @IBOutlet var sourceTextLabel: UILabel!
  @IBOutlet var destinationTextLabel: UILabel!
  
  var crossRef : CrossRef? = nil
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func loadCrossRef(ref:CrossRef) {
    crossRef = ref
    
    let sourceText = (ref.source_ref!.record_text as NSString).substringWithRange(NSMakeRange(ref.source_index, ref.source_length))
    
    let destinationText = (ref.destination_ref!.record_text as NSString).substringWithRange(NSMakeRange(ref.destination_index, ref.destination_index))

    let sourceBook = ref.source_ref!.book!.name
    let destinationBook = ref.destination_ref!.book!.name
    
    sourceTextView.text = sourceText
    sourceTextLabel.text = sourceBook
    
    destinationTextView.text = destinationText
    destinationTextLabel.text = destinationBook
  }
  
  func textViewDidChange(textView: UITextView) {
    let fixedWidth = textView.frame.size.width
    textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
    let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
    var newFrame = textView.frame
    newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
    textView.frame = newFrame
  }
  
//  func textViewDidChange(textView: UITextView) {
//    
//    // Resize the textView
//    let fixedWidth = textView.frame.size.width
//    textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
//    let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
//    var newFrame = textView.frame
//    newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
//    textView.frame = newFrame;
//    
//  }
}
