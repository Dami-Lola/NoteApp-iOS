//
//  ViewController.swift
//  NoteApp
//
//  Created by Damilola Okafor on 12/1/20.
//  Copyright © 2020 Damilola Okafor. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    
    var notes = [Notes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNotes()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return notes.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Notescell", for: indexPath)
        
        let item = notes[indexPath.row]
        cell.textLabel?.text = item.title
        
        return cell
    }
    
    // MARK: - Data manipluations
    
    func saveNotes(){
        
        do {
            try context.save()
        }
        catch{
            print("Error saving Note\(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadNotes(with request: NSFetchRequest<Notes> = Notes.fetchRequest()){
        
        
        do {
            notes = try context.fetch(request)
        }
            
        catch{
            print("Error fetching Notes\(error)")
        }
        
        tableView.reloadData()
    }
    
    
    // MARK: - Add Notes
    
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert  = UIAlertController(title: "Add New Note", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Note", style: .default) { (action) in
            
            
            let newNote = Notes(context: self.context)
            newNote.title = textField.text!
            self.notes.append(newNote)
            self.saveNotes()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new note"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    // MARK: - Table view Delegate methods
    
    
}

//MARK:- Search Bar Methods

extension ViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // to read from the data, always create a request throguh NSFetchRequest
        let request: NSFetchRequest<Notes> = Notes.fetchRequest()
        print("searchBar.text!")
        
        //to query object using core date NSPredicate
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        //to sort the data
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        request.predicate = predicate
        
        loadNotes(with: request)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadNotes()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
}

