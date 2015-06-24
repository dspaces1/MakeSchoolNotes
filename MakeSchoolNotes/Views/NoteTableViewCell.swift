//
//  NoteTableViewCell.swift
//  MakeSchoolNotes
//
//  Created by Martin Walsh on 29/05/2015.
//  Copyright (c) 2015 MakeSchool. All rights reserved.
//

import Foundation
import UIKit

class NoteTableViewCell: UITableViewCell {
    
  @IBOutlet weak var noteDate: UILabel!
  @IBOutlet weak var noteTitle: UILabel!
  
  
  // initialize the date formatter only once, using a static computed property
  static var dateFormatter: NSDateFormatter = {
    var formatter = NSDateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
    }()
  
  var note: Note? {
    didSet {
      if let note = note, noteTitle = noteTitle, noteDate = noteDate {
        self.noteTitle.text = note.title
        self.noteDate.text = NoteTableViewCell.dateFormatter.stringFromDate(note.date)
      }
    }
  }
  
}
