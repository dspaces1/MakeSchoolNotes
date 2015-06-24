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
      
      
      //Test
      currentNote = Note()
      currentNote!.title   = "Super Simple Test Note"
      currentNote!.content = "A long piece of content"
   
      println("Inside segue in NewNotes")
      
    
    }
  

}
