//
//  BingoViewController.swift
//  FYP
//
//  Created by Project  on 02/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import CoreData

class BingoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BingoTableViewCell", for: indexPath) as! BingoTableViewCell
        
        let gameEvent = gameEvents[indexPath.row]
        
        cell.eventLbl.text = gameEvent.type + " by " + gameEvent.player + " during period(s) " + gameEvent.period
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //getting the index path of selected row
        let indexPath = tableView.indexPathForSelectedRow
        
        //getting the current cell from the index path
        let currentCell = tableView.cellForRow(at: indexPath!)! as! BingoTableViewCell
       
        currentCell.backgroundColor = UIColor.lightGray
        
        
    }
    
    
    var fixture: FixtureItem? = nil
    var currentUser: UserItem?
    var gameEvents: [BingoEventItem] = []
    
    private func loadGameEvents() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "BingoEvent", in: context)
        let newGameEvent = NSManagedObject(entity: entity!, insertInto: context)
        newGameEvent.setValue("Robert Farmer", forKey: "player")
        newGameEvent.setValue("Slashing penalty", forKey: "type")
        newGameEvent.setValue("1/2/3", forKey: "period")
        newGameEvent.setValue("23", forKey: "id")
        newGameEvent.setValue(fixture?.id, forKey: "fixtureID")
        let newGameEvent2 = NSManagedObject(entity: entity!, insertInto: context)
        newGameEvent2.setValue("Steve Lee", forKey: "player")
        newGameEvent2.setValue("Cross check penalty", forKey: "type")
        newGameEvent2.setValue("1/2", forKey: "period")
        newGameEvent2.setValue("24", forKey: "id")
        newGameEvent2.setValue(fixture?.id, forKey: "fixtureID")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.dataSource = self
//        tableView.delegate = self
        //loadGameEvents()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BingoEvent")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "type") ?? "")
                print(data.value(forKey: "player") ?? "")
                print(data.value(forKey: "period") ?? "")
                print(data.value(forKey: "id") ?? "")
                print(data.value(forKey: "fixtureID") ?? "")
                let gameEvent = BingoEventItem(type: data.value(forKey: "type") as! String, player: data.value(forKey: "player") as! String, period: data.value(forKey: "period") as! String, id: data.value(forKey: "id") as! String, fixtureID: data.value(forKey: "fixtureID") as! String, selected: data.value(forKey: "selected") as! Bool)
                
                gameEvents += [gameEvent]
            }
            
        } catch {
            
            print("Failed")
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func submit(_ sender: UIButton) {
        //loop through all cells in table
        //if a cell is selected, store as a users bingo card
        
    }
}
