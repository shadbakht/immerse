//
//  ReaderPresenter.swift
//  Immerse
//
//  Created by James Tan on 10/15/15.
//  Copyright © 2015 Immerse. All rights reserved.
//

import UIKit

class ReaderPresenter: NSObject {

  static let sharedInstance : ReaderPresenter = ReaderPresenter()
  var view : ReaderView? = nil
  var interactor : ReaderInteractor? = nil
  
  var current_writing_body : String? = nil
  var current_writing_name : String? = nil
  var current_progress : Float = 0.0
  var current_offset : CGFloat = 0.0
  
  var isSetup : Bool = false
  
  func setup() {
    
    current_writing_body = interactor?.getCurrentBody()
    view!.writingBody.text = current_writing_body
    current_progress = (interactor?.getCurrentProgress())!
    if current_progress > 0.0 {
      current_offset = CGFloat(current_progress * Float(view!.writingBody.contentSize.height))
      current_offset = 2 * view!.writingBody.frame.height + current_offset
    }
    
    let notes = interactor!.getCurrentNotes()
    for note in notes {
      displayAnnotation(note)
    }
    
    let tags = interactor!.getCurrentTags()
    for tag in tags {
      displayAnnotation(tag)
    }
    
    let refs = interactor!.getCurrentRefs()
    for ref in refs {
      displayAnnotation(ref)
    }
    
    if !isSetup {
      isSetup = true
    }
  }
  
  func updateProgress(scroll:UIScrollView) {
    let offsetY = scroll.contentOffset.y
    let total = scroll.contentSize.height
    let progress = Float(offsetY/total)
    if interactor!.updateCurrentProgress(progress) {
      current_progress = progress
    }
  }
  
  func createNote(range:NSRange, details:UITextView) {
    let text = details.text
    let attributedString = NSMutableAttributedString(attributedString: view!.writingBody.attributedText)
    attributedString.addAttribute(NSBackgroundColorAttributeName, value: UIColor.redColor(), range: range)
    view!.writingBody.attributedText = attributedString
    interactor!.createNote(range,text:text)
  }
  
  func createRef(data:NSDictionary) {
    let writing_id = data.objectForKey("writing_id") as! String
    let start = data.objectForKey("start") as! Int
    let length = data.objectForKey("length") as! Int
    let range = NSMakeRange(start, length)
    let attributedString = NSMutableAttributedString(attributedString: view!.writingBody.attributedText)
    attributedString.addAttribute(NSBackgroundColorAttributeName, value: UIColor.orangeColor(), range: range)
    view!.writingBody.attributedText = attributedString
    interactor!.createRef(writing_id, range: range)
  }
  
  func createTag(range:NSRange, tagTypes:NSArray) {
    let attributedString = NSMutableAttributedString(attributedString: view!.writingBody.attributedText)
    attributedString.addAttribute(NSBackgroundColorAttributeName, value: UIColor.greenColor(), range: range)
    view!.writingBody.attributedText = attributedString
    interactor!.createTag(range, tags:tagTypes)
  }
  
  func createTagLabel(name:String) {
    interactor!.createTagLabel(name)
  }
  
  func displayAnnotation(item:AnyObject?) {
    if item is Note {
      let noteObj = item as! Note
      let range = NSMakeRange(noteObj.start_position, noteObj.length)
      let attributedString = NSMutableAttributedString(attributedString: view!.writingBody.attributedText)
      attributedString.addAttribute(NSBackgroundColorAttributeName, value: UIColor.redColor(), range: range)
      view!.writingBody.attributedText = attributedString
    }
    if item is Tag {
      let tagObj = item as! Tag
      let range = NSMakeRange(tagObj.start_position, tagObj.length)
      let attributedString = NSMutableAttributedString(attributedString: view!.writingBody.attributedText)
      attributedString.addAttribute(NSBackgroundColorAttributeName, value: UIColor.greenColor(), range: range)
      view!.writingBody.attributedText = attributedString
    }
    if item is CrossRef {
      let refObj = item as! CrossRef
      let range = NSMakeRange(refObj.start_position, refObj.length)
      let attributedString = NSMutableAttributedString(attributedString: view!.writingBody.attributedText)
      attributedString.addAttribute(NSBackgroundColorAttributeName, value: UIColor.yellowColor(), range: range)
      view!.writingBody.attributedText = attributedString

    }
  }
  
  func fetchAnnotationDetails() {
    
  }

  // MARK Delegates for the TagView
  
  func tagTypes() -> NSArray {
    return interactor!.tagTypes()
  }
  
  func tagTypeCellForIndexPath(tableView:UITableView, indexPath:NSIndexPath) -> UITableViewCell {
    let tags = interactor!.tagTypes()
    let tagName : TagTypes = tags.objectAtIndex(indexPath.row) as! TagTypes
    let cell : UITableViewCell = UITableViewCell()
    cell.textLabel!.text = tagName.tag_type_name
    return cell
  }
  
  func refs() -> NSArray {
    return interactor!.getCurrentRefs()
  }
  
  func refCellForIndexPath(tableView:UITableView, indexPath:NSIndexPath) -> UITableViewCell {
    let cell : UITableViewCell = UITableViewCell()
    let refs = interactor!.getCurrentRefs()
    let ref : CrossRef = refs.objectAtIndex(indexPath.row) as! CrossRef
    let text : String = "Reference: " + ref.writing_id_end + " to " + ref.writing_id_start
    cell.textLabel.text = text
    return cell
  }
  
  //MARK: Detect Tap Gesture
  // from: http://stackoverflow.com/questions/19332283/detecting-taps-on-attributed-text-in-a-uitextview-in-ios
//  - (void)textTapped:(UITapGestureRecognizer *)recognizer
//  {
//  UITextView *textView = (UITextView *)recognizer.view;
//  
//  // Location of the tap in text-container coordinates
//  
//  NSLayoutManager *layoutManager = textView.layoutManager;
//  CGPoint location = [recognizer locationInView:textView];
//  location.x -= textView.textContainerInset.left;
//  location.y -= textView.textContainerInset.top;
//  
//  // Find the character that's been tapped on
//  
//  NSUInteger characterIndex;
//  characterIndex = [layoutManager characterIndexForPoint:location
//  inTextContainer:textView.textContainer
//  fractionOfDistanceBetweenInsertionPoints:NULL];
//  
//  if (characterIndex < textView.textStorage.length) {
//  
//  NSRange range;
//  id value = [textView.attributedText attribute:@"myCustomTag" atIndex:characterIndex effectiveRange:&range];
//  
//  // Handle as required...
//  
//  NSLog(@"%@, %d, %d", value, range.location, range.length);
//  
//  }
//  }

}
