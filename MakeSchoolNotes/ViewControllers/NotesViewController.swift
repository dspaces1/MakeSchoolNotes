//
//  ViewController.swift
//  MakeSchoolNotes
//
//  Created by Martin Walsh on 29/05/2015.
//  Copyright (c) 2015 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class NotesViewController: UIViewController {

  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  
  enum State {
    case DefaultMode
    case SearchMode
  }
  
  var state: State = .DefaultMode
  
  @IBOutlet weak var notesTableView: UITableView!
  
  
  @IBAction func unwindToSegue (segue: UIStoryboardSegue){
    
    if let identifier = segue.identifier { let realm = Realm()
      
      switch identifier {
        
      case "Save":
        let source = segue.sourceViewController as! NewNotesViewController //1
        realm.write() {
          realm.add(source.currentNote!)
        }
        
      case "Delete":
        realm.write() {
          
          realm.delete(self.selectedNote!)
        }
        
        let source = segue.sourceViewController as! NoteDisplayViewController
        source.note = nil;
        
        
      default:
        println("No one loves \(identifier)")
      }
      
      notes = realm.objects(Note).sorted("date", ascending: false) //2
    }
    
  }
  
  var selectedNote:Note?
  
  var notes: Results<Note>! {
    didSet {
      // Whenever notes update, update the table view
      notesTableView?.reloadData()
    }
  }
  
  func searchNotes(searchString: String) -> Results<Note> {
    let realm = Realm()
    let searchPredicate = NSPredicate(format: "title CONTAINS[c] %@ OR content CONTAINS[c] %@", searchString, searchString)
    return realm.objects(Note).filter(searchPredicate)
  }
  
  
  /*
  /   Set Up functions
  */

    override func viewDidLoad() {
      super.viewDidLoad()
      
      notesTableView.dataSource = self
      notesTableView.delegate = self
      //searchBar.delegate = self
    }
  
  override func viewWillAppear(animated: Bool) {
    
    super.viewWillAppear(animated)
    let realm = Realm()
    notes = realm.objects(Note).sorted("date", ascending: false)
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "ShowExistingNote") {
      let noteViewController = segue.destinationViewController as! NoteDisplayViewController
      noteViewController.note = selectedNote
    }
  }

}

extension NotesViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("NoteCell", forIndexPath: indexPath) as! NoteTableViewCell //1
    
    
    let row = indexPath.row
    let note = notes[row] as Note
    cell.note = note
    
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Int(notes?.count ?? 0)
  }
  
}

extension NotesViewController: UITableViewDelegate{
  
  
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    selectedNote = notes[indexPath.row]      //1
    self.performSegueWithIdentifier("ShowExistingNote", sender: self)     //2
  }

  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    
    if editingStyle == .Delete {
      let note = notes[indexPath.row] as Object
      
      let realm = Realm()
      
      realm.write() {
        realm.delete(note)
      }
      
      notes = realm.objects(Note).sorted("date", ascending: false)
    
    }
  }

}