//
//  TagCell.swift
//  Immerse
//
//  Created by James Tan on 12/31/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

class TagCell: UITableViewCell {

  @IBOutlet weak var selectDeleteButton: UIButton!
  @IBOutlet weak var editButton: UIButton!
  @IBOutlet weak var tagNameTextField: UITextField!
  var id : String? = nil
  var level : Int? = nil
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  @IBAction func editSelected(sender: UIButton) {
    if !editButton.selected {
      // Enable Editing
      tagNameTextField.userInteractionEnabled = true
      tagNameTextField.becomeFirstResponder()
      editButton.selected = true
    } else {
      // Disable Editing
      tagNameTextField.userInteractionEnabled = false
      tagNameTextField.resignFirstResponder()
      editButton.selected = false
    }
  }
  
  @IBAction func deleteSelected(sender: UIButton) {
    if selectDeleteButton.selected {
      
    }
  }
  
  func set(text:String, level:Int? = nil, id:String? = nil) {
    tagNameTextField.text = text
    self.level = level
    self.id = id
  }
  
  func configureMode(editMode:Bool) {
    if editMode {
      selectDeleteButton.selected = true
      editButton.alpha = 1.0
      
    } else {
      selectDeleteButton.selected = false
      editButton.alpha = 0.0
    }
  }
}
