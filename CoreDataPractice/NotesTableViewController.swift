//
//  NotesTableViewController.swift
//  CoreDataPractice
//
//  Created by Jonah Zukosky on 7/26/18.
//  Copyright © 2018 Zukosky, Jonah. All rights reserved.
//

import UIKit
import CoreData


class NotesTableViewController: UITableViewController {

    var notes = [Note]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        
        do {
            notes = try managedContext.fetch(fetchRequest)
            self.tableView.reloadData()
        }catch {
            print("it ain't work")
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteTableViewCell

        cell.titleLabel.text = notes[indexPath.row].title
        cell.bodyLabel.text = notes[indexPath.row].body

        return cell
    }
    
    @IBAction func addNote(_ sender: Any) {
        let alert = UIAlertController(title: "New Note", message: "Add your notes here!", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Add", style: UIAlertActionStyle.default) { _ in
            guard let textFields = alert.textFields else {return}
            
            let titleForm = textFields[0]
            let bodyForm = textFields[1]
            
            print(titleForm.text ?? "didn't work")
            print(bodyForm.text ?? "didn't work body")
            
            if let title = titleForm.text, let body = bodyForm.text {
                if let newNote = Note(title: title, body: body) {
                
                    do {
                        let managedContext = newNote.managedObjectContext
                        try managedContext?.save()
                        self.notes.append(newNote)
                        self.tableView.reloadData()
                    } catch {
                        print("context could not be saved")
                        alert.dismiss(animated: true, completion: nil)
                    }
                }
                
            }else {
                alert.dismiss(animated: true, completion: nil)
            }
            
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        
        
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        alert.addTextField { (titleForm) in
            titleForm.placeholder = "Title"
        }
        alert.addTextField { (bodyForm) in
            bodyForm.placeholder = "Body"
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        if editingStyle == .delete {
            let managedContext = appDelegate.persistentContainer.viewContext
            managedContext.delete(notes[indexPath.row])
            do {
                try managedContext.save()
            } catch {
                print("Couldn't save it")
            }
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
