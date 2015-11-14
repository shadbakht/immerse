//
//  ReaderView.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
import KYDrawerController
import CNPPopupController

class ImmerseTextView : UITextView {

  var parent : ReaderView? = nil
  
  override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
    if action == "createTag" || action == "createNote" || action == "createXRef" {
      return true
    }
    return false
  }

  func createTag() {
    parent?.createTag(self)
  }
  
  func createNote() {
    parent?.createNote(self)
  }
  
  func createXRef() {
    parent?.createXRef(self)
  }
}

class ReaderTagAccessoryView : UIView {
  
}


class ReaderView: UIViewController {

  var presenter : ReaderPresenter? = nil
  @IBOutlet weak var writingBody: ImmerseTextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // SETUP VIPER
    presenter = ReaderPresenter.sharedInstance
    presenter?.view = self
    presenter?.interactor = ReaderInteractor.sharedInstance
    ReaderInteractor.sharedInstance.presenter = presenter
    presenter?.setup()
    
    // Custom Menu Items & Behaviors
    // Setup the Delegation Pattern
    writingBody.parent = self
    let tagItem = UIMenuItem(title: "TAG", action: "createTag")
    let noteItem = UIMenuItem(title: "NOTE", action: "createNote")
    let xrefItem = UIMenuItem(title: "X-REF", action: "createXRef")
    UIMenuController.sharedMenuController().menuItems = [tagItem, noteItem, xrefItem]
    UIMenuController.sharedMenuController().setMenuVisible(true, animated: true)
  }
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.writingBody.setContentOffset(CGPointZero, animated: false)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func menuOpen(sender: UIBarButtonItem) {
    if let drawerController = navigationController?.parentViewController as? KYDrawerController {
      drawerController.setDrawerState(.Opened, animated: true)
    }
  }
  
  //MARK: Text Annotations Delegate Methods
  func createNote(tv:ImmerseTextView) {
    let range = tv.selectedRange
    presenter?.createNote(range)
    
  }
  
  func createTag(tv: ImmerseTextView) {
    let range = tv.selectedRange
    presenter?.createTag(range)
    
    //Create Popup
    let nib = NSBundle.mainBundle().loadNibNamed("ReaderTagsAccessory", owner: nil, options: nil)
    let view : ReaderTagAccessoryView = (nib as NSArray).objectAtIndex(0) as! ReaderTagAccessoryView
    view.frame = CGRectMake(0, 0, self.view.frame.width, 250)
    let popup = CNPPopupController(contents: [view]) as CNPPopupController
    popup.theme.popupContentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    popup.theme.shouldDismissOnBackgroundTouch = true
    popup.theme.popupStyle = CNPPopupStyle.ActionSheet
    popup.presentPopupControllerAnimated(true)

  }
  
  func createXRef(tv: ImmerseTextView) {
    let range = tv.selectedRange
    presenter?.createRef(range)
  }
}
