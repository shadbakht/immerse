//
//  ReaderView.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit
//import QuartzCore
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
  var parent : ReaderView? = nil
  var selectedRange : NSRange? = nil
  
  @IBOutlet weak var tagsTable: UITableView!
  @IBAction func close(sender: AnyObject) {
    parent?.closePopup()
  }
  
  @IBAction func add(sender: AnyObject) {
  }
  @IBAction func edit(sender: AnyObject) {
  }
}

class ReaderNoteAccessoryView : UIView, UITextViewDelegate {
  var parent : ReaderView? = nil
  var selectedRange : NSRange? = nil
  @IBOutlet weak var notes: UITextView!
  func config() {
    notes.delegate = self
    NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
    NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
  }
  @IBAction func close(sender: AnyObject) {
    parent?.closePopup()
  }
  @IBAction func saveNote(sender: AnyObject) {
    parent?.presenter!.createNote(selectedRange!, details:notes)
    parent?.closePopup()
  }
  func keyboardWillShow(sender: NSNotification) {
    self.superview?.frame.origin.y = 30
  }
  func keyboardWillHide(sender: NSNotification) {
    self.superview?.frame.origin.y = 30
  }

  func textViewDidBeginEditing(textView: UITextView) {
    textView.text = ""
  }
}

class ReaderXRefAccessoryView : UIView {
  var parent : ReaderView? = nil
  var selectedRange : NSRange? = nil

  @IBAction func close(sender: AnyObject) {
    parent?.closePopup()
  }
}


class ReaderView: UIViewController {

  var presenter : ReaderPresenter? = nil
  @IBOutlet weak var writingBody: ImmerseTextView!
  var popup : CNPPopupController? = nil
  
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
  
  //MARK: Accessory View Delegates
  
  func closePopup() {
    popup?.dismissPopupControllerAnimated(true)
  }
  
  
  //MARK: Text Annotations Delegate Methods
  
  func createNote(tv:ImmerseTextView) {
    let view : ReaderNoteAccessoryView = createView("ReaderNotesAccessory") as! ReaderNoteAccessoryView
    view.selectedRange = tv.selectedRange
    view.parent = self
    view.config()
    createPopup(view)

  }
  
  func createTag(tv: ImmerseTextView) {
    let view : ReaderTagAccessoryView = createView("ReaderTagsAccessory") as! ReaderTagAccessoryView
    view.selectedRange = tv.selectedRange
    view.parent = self
    createPopup(view)
  }
  
  func createXRef(tv: ImmerseTextView) {
    let view : ReaderXRefAccessoryView = createView("ReaderXRefsAccessory") as! ReaderXRefAccessoryView
    view.selectedRange = tv.selectedRange
    view.parent = self
    createPopup(view)

  }

  func createView(nibName:String, index:Int = 0) -> UIView? {
    let nib = NSBundle.mainBundle().loadNibNamed(nibName, owner: nil, options: nil)
    let view = (nib as NSArray).objectAtIndex(index)
    return (view as! UIView)
  }
  
  func createPopup(view: UIView) {
    view.frame = CGRectMake(0, 0, self.view.frame.width, 250)
    popup = CNPPopupController(contents: [view]) as CNPPopupController
    popup?.theme.popupContentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    popup?.theme.shouldDismissOnBackgroundTouch = true
    popup?.theme.popupStyle = CNPPopupStyle.ActionSheet
    popup?.theme.maskType = CNPPopupMaskType.Dimmed
    popup?.theme.movesAboveKeyboard = true
    popup?.presentPopupControllerAnimated(true)
    
  }
  
  
}
