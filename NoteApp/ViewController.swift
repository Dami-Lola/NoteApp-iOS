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
            print("Erro fetching Notes\(error)")
        }
        
        tableView.reloadData()
    }
    
    
    // MARK: - Add Notes
    
    
    // MARK: - Table view Delegate methods

}

