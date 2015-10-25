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
  var current_annotations : NSArray = []
  
  var isSetup : Bool = false
  
  func setup() {
    
    current_writing_body = interactor?.getCurrentBody()
    view!.writingBody.text = current_writing_body
    
    if !isSetup {
      isSetup = true
    }
  }
  
  func createNote(range:NSRange) {
   let attributedString = NSMutableAttributedString(attributedString: view!.writingBody.attributedText)
    attributedString.addAttribute(NSBackgroundColorAttributeName, value: UIColor.redColor(), range: range)
    view!.writingBody.attributedText = attributedString
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
