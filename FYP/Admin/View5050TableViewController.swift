//
//  5050TableViewController.swift
//  FYP
//
//  Created by Project  on 26/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import CoreData

class View5050TableViewController: UITableViewController {

    var tickets: [Ticket50Item] = []
    var fixture: FixtureItem?
    
    @IBOutlet weak var selectWinner: UIBarButtonItem!
    @IBAction func selectWinner(_ sender: UIBarButtonItem) {
        //randomly choose a table view cell
        let randomTicket = tickets.randomElement()
        print(randomTicket?.id ?? "")
        
        
        //remove all other cells from the table view by setting won to false
        //only display winning ticket 
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Ticket50")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if data.value(forKey: "fixtureID") as? String == fixture?.id {
                    print("FixtureID: ", data.value(forKey: "fixtureID") as? String ?? "")
                    print("ID: ", data.value(forKey: "id") as? String ?? "")
                    print("Owner: ", data.value(forKey: "owner") as? String ?? "")
                    if (data.value(forKey: "won") != nil && true) {
                    let ticket = Ticket50Item(id: data.value(forKey: "id") as! String, owner: data.value(forKey: "owner") as! String, fixtureID: data.value(forKey: "fixtureID") as! String, won: (data.value(forKey: "won") != nil))
                    tickets += [ticket]
                    }
                }
            }
            
        } catch {
            
            print("Failed")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tickets.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TicketTableViewCell", for: indexPath) as! TicketTableViewCell
        
        let ticket = tickets[indexPath.row]
        cell.number.text = ticket.id
        cell.userID.text = ticket.owner
        
        return cell
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
