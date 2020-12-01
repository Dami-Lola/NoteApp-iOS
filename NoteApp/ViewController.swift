//
//  ViewController.swift
//  NoteApp
//
//  Created by Damilola Okafor on 12/1/20.
//  Copyright © 2020 Damilola Okafor. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate)
    .persistentContainer.viewContext
    
    let notes = [Notes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    
    
    // MARK: - Table view Delegate methods
    
    // MARK: - Add Notes

}

