//
//  TeamsTableViewController.swift
//  FYP
//
//  Created by Project  on 06/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import CoreData

class TeamsTableViewController: UITableViewController {
    
    var teams: [TeamItem] = []
    
    private func loadTeams() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Team", in: context)
        let nottinghamPanthers = NSManagedObject(entity: entity!, insertInto: context)
        nottinghamPanthers.setValue("Nottingham Panthers", forKey: "name")
        let braeheadClan = NSManagedObject(entity: entity!, insertInto: context)
        braeheadClan.setValue("Braehead Clan", forKey: "name")
        let cardiffDevils = NSManagedObject(entity: entity!, insertInto: context)
        cardiffDevils.setValue("Cardiff Devils", forKey: "name")
        let belfastGiants = NSManagedObject(entity: entity!, insertInto: context)
        belfastGiants.setValue("Belfast Giants", forKey: "name")
        let manchesterStorm = NSManagedObject(entity: entity!, insertInto: context)
        manchesterStorm.setValue("Manchester Storm", forKey: "name")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTeams()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Team")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let team = TeamItem(name: data.value(forKey: "name") as! String)
                teams += [team]
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
        return teams.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamTableViewCell", for: indexPath) as! TeamTableViewCell
        
        let team = teams[indexPath.row]
        
        cell.teamLogo.image = UIImage(named: team.name)
        cell.teamName.text = team.name
        
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
        super.prepare(for: segue, sender: sender)
        
        //switch statement for each segue
        switch(segue.identifier ?? "") {
        case "ViewPlayers":
            guard let teamViewController = segue.destination as? AdminPlayersTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedTeamCell = sender as? TeamTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedTeamCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let team = teams[indexPath.row]
            teamViewController.team = team
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    
    @IBAction func unwindToFixtureList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddTeamViewController, let team = sourceViewController.team {
            
            let newIndexPath = IndexPath(row: teams.count, section: 0)
            
            teams.append(team)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Team", in: context)
            let newTeam = NSManagedObject(entity: entity!, insertInto: context)
            newTeam.setValue(team.name, forKey: "name")
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
        }
    }

}
