//
//  NoteDisplayViewController.swift
//  MakeSchoolNotes
//
//  Created by Diego Urquiza on 6/24/15.
//  Copyright (c) 2015 MakeSchool. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import ConvenienceKit

class NoteDisplayViewController: UIViewController {

  @IBOutlet weak var titleTextField: UITextField!
    
  @IBOutlet weak var contentTextView: TextView!
  
  @IBOutlet weak var deleteButton: UIBarButtonItem!
  @IBOutlet weak var toolbarBottomSpace: NSLayoutConstraint!
  
  var edit:Bool = false
  
  var keyboardNotificationHandler: KeyboardNotificationHandler?
  
  var note: Note? {
    didSet {
      displayNote(note)
    }
  }
  
  func displayNote(note: Note?) {
    if let note = note, titleTextField = titleTextField, contentTextView = contentTextView  {
      titleTextField.text = note.title
      contentTextView.text = note.content
      
      if count(note.title)==0 && count(note.content)==0 { //1
        titleTextField.becomeFirstResponder()
      }
      
    }
  }
  

  func saveNote(){
    if let note = note {
      let realm = Realm()
      
      realm.write{
        if (note.title != self.titleTextField.text || note.content != self.contentTextView.textValue){
          note.title = self.titleTextField.text
          note.content = self.contentTextView.textValue
          note.date = NSDate()
        }
      }
    }
  }
  
  override func viewDidLoad() {
      super.viewDidLoad()

      // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    displayNote(self.note)
    
    titleTextField.returnKeyType = .Next
    titleTextField.delegate = self
    
    keyboardNotificationHandler = KeyboardNotificationHandler()
    
    
    keyboardNotificationHandler!.keyboardWillBeHiddenHandler = { (height: CGFloat) in
      UIView.animateWithDuration(0.3){
        self.toolbarBottomSpace.constant = 0
        self.view.layoutIfNeeded()
      }
    }
    
    keyboardNotificationHandler!.keyboardWillBeShownHandler = { (height: CGFloat) in
      UIView.animateWithDuration(0.3) {
        self.toolbarBottomSpace.constant = height
        self.view.layoutIfNeeded()
      }
    }
    
    if edit {
      deleteButton.enabled = false
    }
    
    
    self.navigationController!.setNavigationBarHidden(false, animated: true)
    
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    
    saveNote()
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension NoteDisplayViewController: UITextFieldDelegate{
  
  
  func textFieldShouldReturn(textField: UITextField) -> Bool{
    
    if textField == titleTextField {
      contentTextView.becomeFirstResponder()
      contentTextView.returnKeyType = .Done
    }
    return false
  }
  
}
