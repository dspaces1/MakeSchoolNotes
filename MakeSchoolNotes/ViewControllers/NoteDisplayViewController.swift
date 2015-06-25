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
  
  var note: Note? {
    didSet {
      displayNote(note)
    }
  }
  
  func displayNote(note: Note?) {
    if let note = note, titleTextField = titleTextField, contentTextView = contentTextView  {
      titleTextField.text = note.title
      contentTextView.text = note.content
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
    displayNote(note)
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
