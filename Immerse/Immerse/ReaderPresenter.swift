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
  
  var isSetup : Bool = false
  
  func setup() {
    
    current_writing_body = interactor?.getCurrentBody()
    view!.writingBody.text = current_writing_body
    
    let notes = interactor!.getCurrentNotes()
    for note in notes {
      displayAnnotation(note)
    }
    
    if !isSetup {
      isSetup = true
    }
  }
  
  func createNote(range:NSRange, details:UITextView) {
    let text = details.text
    let attributedString = NSMutableAttributedString(attributedString: view!.writingBody.attributedText)
    attributedString.addAttribute(NSBackgroundColorAttributeName, value: UIColor.redColor(), range: range)
    view!.writingBody.attributedText = attributedString
    interactor!.createNote(range,text:text)
  }
  
  func createRef(range:NSRange) {
    let attributedString = NSMutableAttributedString(attributedString: view!.writingBody.attributedText)
    attributedString.addAttribute(NSBackgroundColorAttributeName, value: UIColor.orangeColor(), range: range)
    view!.writingBody.attributedText = attributedString
  }
  
  func createTag(range:NSRange) {
    let attributedString = NSMutableAttributedString(attributedString: view!.writingBody.attributedText)
    attributedString.addAttribute(NSBackgroundColorAttributeName, value: UIColor.greenColor(), range: range)
    view!.writingBody.attributedText = attributedString
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
      
    }
    if item is CrossRef {
      
    }
  }
  
  func fetchAnnotationDetails() {
    
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
