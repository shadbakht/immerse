//
//  RecentCell.swift
//  Immerse
//
//  Created by James Tan on 5/8/16.
//  Copyright © 2016 Immerse. All rights reserved.
//

import UIKit

class RecentCell: UITableViewCell {

  @IBOutlet weak var bookTitle: UILabel!
  @IBOutlet weak var bookSub: UILabel!
  @IBOutlet weak var bookProgressLabel: UILabel!
  @IBOutlet weak var bookProgress: UIProgressView!
  
  var book : Book? = nil
  var progress : Progress? = nil
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func load(progress:Progress, tagCount:Int=0, noteCount:Int=0, refCount:Int=0) {
    self.bookTitle.text = progress.writing!.name
    self.bookSub.text = "\(tagCount) TAGS, \(noteCount) NOTES, \(refCount) CROSS REFS"
    self.bookProgress.progress = progress.percent
    self.bookProgressLabel.text = "\(Int(progress.percent * 100)) %"
  }
    
}
