//
//  PlayersTableViewController.swift
//  FYP
//
//  Created by Project  on 02/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import CoreData
import os.log

class PlayersTableViewController: UITableViewController {
    
    //MARK: Properties
    var players: [PlayerItem] = []
    var team: TeamItem?
    
    //MARK: Methods
    private func loadPlayers() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Player", in: context)
        let RobertFarmer = NSManagedObject(entity: entity!, insertInto: context)
        RobertFarmer.setValue("Robert Farmer", forKey: "name")
        RobertFarmer.setValue("19", forKey: "number")
        RobertFarmer.setValue("United Kingdom", forKey: "country")
        RobertFarmer.setValue("Nottingham Panthers", forKey: "team")
        RobertFarmer.setValue("28", forKey: "age")
        let SteveLee = NSManagedObject(entity: entity!, insertInto: context)
        SteveLee.setValue("Steve Lee", forKey: "name")
        SteveLee.setValue("45", forKey: "number")
        SteveLee.setValue("United Kingdom", forKey: "country")
        SteveLee.setValue("Nottingham Panthers", forKey: "team")
        SteveLee.setValue("29", forKey: "age")
        let BenBowns = NSManagedObject(entity: entity!, insertInto: context)
        BenBowns.setValue("Ben Bowns", forKey: "name")
        BenBowns.setValue("33", forKey: "number")
        BenBowns.setValue("United Kingdom", forKey: "country")
        BenBowns.setValue("Cardiff Devils", forKey: "team")
        BenBowns.setValue("27", forKey: "age")
        let JoshBatch = NSManagedObject(entity: entity!, insertInto: context)
        JoshBatch.setValue("Josh Batch", forKey: "name")
        JoshBatch.setValue("41", forKey: "number")
        JoshBatch.setValue("United Kingdom", forKey: "country")
        JoshBatch.setValue("Cardiff Devils", forKey: "team")
        JoshBatch.setValue("28", forKey: "age")
        let ZackFitz = NSManagedObject(entity: entity!, insertInto: context)
        ZackFitz.setValue("Zach Fitzgerald", forKey: "name")
        ZackFitz.setValue("13", forKey: "number")
        ZackFitz.setValue("United States", forKey: "country")
        ZackFitz.setValue("Braehead Clan", forKey: "team")
        ZackFitz.setValue("33", forKey: "age")
        let CraigPeacock = NSManagedObject(entity: entity!, insertInto: context)
        CraigPeacock.setValue("Craig Peacock", forKey: "name")
        CraigPeacock.setValue("71", forKey: "number")
        CraigPeacock.setValue("United Kingdom", forKey: "country")
        CraigPeacock.setValue("Braehead Clan", forKey: "team")
        CraigPeacock.setValue("30", forKey: "age")
        let PaulSwindlehurst = NSManagedObject(entity: entity!, insertInto: context)
        PaulSwindlehurst.setValue("Paul Swindlehurst", forKey: "name")
        PaulSwindlehurst.setValue("23", forKey: "number")
        PaulSwindlehurst.setValue("United Kingdom", forKey: "country")
        PaulSwindlehurst.setValue("Belfast Giants", forKey: "team")
        PaulSwindlehurst.setValue("25", forKey: "age")
        let JonathanBoxhill = NSManagedObject(entity: entity!, insertInto: context)
        JonathanBoxhill.setValue("Jonathan Boxhill", forKey: "name")
        JonathanBoxhill.setValue("89", forKey: "number")
        JonathanBoxhill.setValue("United Kingdom", forKey: "country")
        JonathanBoxhill.setValue("Belfast Giants", forKey: "team")
        JonathanBoxhill.setValue("30", forKey: "age")
        let DallasEhrhardt = NSManagedObject(entity: entity!, insertInto: context)
        DallasEhrhardt.setValue("Dallas Ehrhardt", forKey: "name")
        DallasEhrhardt.setValue("10", forKey: "number")
        DallasEhrhardt.setValue("United Kingdom", forKey: "country")
        DallasEhrhardt.setValue("Manchester Storm", forKey: "team")
        DallasEhrhardt.setValue("26", forKey: "age")
        let LoganMacmillian = NSManagedObject(entity: entity!, insertInto: context)
        LoganMacmillian.setValue("Logan MacMillian", forKey: "name")
        LoganMacmillian.setValue("17", forKey: "number")
        LoganMacmillian.setValue("United States", forKey: "country")
        LoganMacmillian.setValue("Manchester Storm", forKey: "team")
        LoganMacmillian.setValue("29", forKey: "age")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }

    //MARK: On Load
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPlayers()
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

    // MARK: - Table View Data Source
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let viewPlayerViewController = segue.destination as? ViewPlayerViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        guard let selectedPlayerCell = sender as? PlayerTableViewCell else {
            fatalError("Unexpected sender: \(String(describing: sender))")
        }
        
        guard let indexPath = tableView.indexPath(for: selectedPlayerCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        let selectedPlayer = players[indexPath.row]
        viewPlayerViewController.player = selectedPlayer
    }
    

}
