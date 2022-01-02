//
//  PlayersTableViewController.swift
//  FYP
//
//  Created by Project  on 26/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import CoreData

class AdminPlayersTableViewController: UITableViewController {

    var players: [PlayerItem] = []
    var team: TeamItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if team?.name == data.value(forKey: "team") as? String {
                let player = PlayerItem(name: data.value(forKey: "name") as! String, number: data.value(forKey: "number") as! String, country: data.value(forKey: "country") as! String, team: data.value(forKey: "team") as! String, age: data.value(forKey: "age") as! String)
                
                players += [player]
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
        return players.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as? PlayerTableViewCell else {
            fatalError()
        }
        
        let player = players[indexPath.row]
        
        cell.playerImg.image = UIImage(named: player.name)
        cell.playerName.text = player.name
        cell.numLbl.text = player.number
        
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //send team over to
    }
    
    @IBAction func unwindToPlayerList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddPlayerViewController, let player = sourceViewController.player {
            
            let newIndexPath = IndexPath(row: players.count, section: 0)
            
            players.append(player)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Player", in: context)
            let newPlayer = NSManagedObject(entity: entity!, insertInto: context)
            newPlayer.setValue(player.name, forKey: "name")
            newPlayer.setValue(player.number, forKey: "number")
            newPlayer.setValue(player.country, forKey: "country")
            newPlayer.setValue(team?.name, forKey: "team")
            newPlayer.setValue(player.age, forKey: "age")
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
        }
    }
}
