//
//  NewNotesViewController.swift
//  MakeSchoolNotes
//
//  Created by Diego Urquiza on 6/23/15.
//  Copyright (c) 2015 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class NewNotesViewController: UIViewController {

  
  var currentNote:Note? 
  
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
      
      
      if segue.identifier == "ShowNewNote" {
        
        // create a new Note and hold onto it, to be able to save it later
        currentNote = Note()
        let noteViewController = segue.destinationViewController as! NoteDisplayViewController
        noteViewController.note = currentNote
      }
     
    
    }
  

}
