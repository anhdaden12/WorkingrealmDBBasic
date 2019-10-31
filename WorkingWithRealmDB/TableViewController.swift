//
//  TableViewController.swift
//  WorkingWithRealmDB
//
//  Created by Apple on 10/31/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewController: UITableViewController {

   // tao bien toan cuc
    let realm = try! Realm()
    var dataDisplay: Results<Person> {
        get {
            return realm.objects(Person.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ViewController2
        if let index = tableView.indexPathForSelectedRow {
            destinationVC.detailPerson = dataDisplay[index.row]
        }
    }
   
    
    @IBAction func onClickAdd(_ sender: Any) {
        let alertController = UIAlertController(title: "Add New", message: "", preferredStyle: .alert)
        alertController.addTextField { (textFieldName) in
            textFieldName.placeholder = "Field Your Name"
            
        }
        alertController.addTextField { (textFieldPhone) in
            textFieldPhone.placeholder = "Field Your Phone"
           
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (alert) in
            let textName = alertController.textFields?[0].text! ?? ""
            let textPhone = Int(alertController.textFields?[1].text! ?? "0")
            let people = Person()
            
            try! self.realm.write {
                people.name = textName
                people.phone = textPhone ?? 0
               
                self.realm.add(people)
            }
            self.tableView.reloadData()
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    

}


extension TableViewController {
    
    // MARK: - Table view data source

       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
           return dataDisplay.count
       }
       
       
       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
           
           cell.textLabel?.text = dataDisplay[indexPath.row].name
           cell.detailTextLabel?.text = "\(dataDisplay[indexPath.row].phone)"
           return cell
       }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! realm.write {
                realm.delete(dataDisplay[indexPath.row])
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
}
