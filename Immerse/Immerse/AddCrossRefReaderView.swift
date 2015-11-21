//
//  AddCrossRefReaderView.swift
//  Immerse
//
//  Created by James Tan on 11/20/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

class ImmerseXRefTextView : UITextView {
  
  var parent : AddCrossRefReaderView? = nil
  
  override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
    if action == "createXRef" {
      return true
    }
    return false
  }
  
  func createXRef() {
    let alert = UIAlertController(title: "CONFIRM X-REF ", message: "Please confirm that you want to create this X-Ref. You will be taken back to your previous writing.", preferredStyle: UIAlertControllerStyle.Alert)
    let actionDone = UIAlertAction(title: "Confirm", style: UIAlertActionStyle.Default, handler: {
      action in
      self.parent!.dismissViewControllerAnimated(true, completion: nil)
    })
    let actionCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {
      action in
    })
    alert.addAction(actionCancel)
    alert.addAction(actionDone)
    parent?.presentViewController(alert, animated: true, completion: {
    })

    
    
  }
}



class AddCrossRefReaderView: UIViewController {

  @IBOutlet weak var textBody: ImmerseXRefTextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    textBody.parent = self
    let createXRef = UIMenuItem(title: "CREATE X-REF", action: "createXRef")
    UIMenuController.sharedMenuController().menuItems = [createXRef]
    UIMenuController.sharedMenuController().setMenuVisible(true, animated: true)

    let body = DataManager.getCurrentXRefBody()
    textBody.text = body
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
