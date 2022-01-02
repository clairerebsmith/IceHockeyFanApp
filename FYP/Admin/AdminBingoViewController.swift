//
//  AdminBingoViewController.swift
//  FYP
//
//  Created by Project  on 20/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import CoreData


class AdminBingoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Properties
    var fixture: FixtureItem? = nil
    var bingoEvents: [BingoEventItem] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bingoEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BingoEventTableViewCell", for: indexPath) as! BingoEventTableViewCell
        
        let bingoEvent = bingoEvents[indexPath.row]
        cell.eventLbl.text = bingoEvent.type
        if(bingoEvent.selected == true) {
            cell.eventLbl.textColor = UIColor.red;
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "BingoEventTableViewCell", for: indexPath) as! BingoEventTableViewCell
//        cell.eventLbl.textColor = UIColor.red;
        
        //search through database
        //set this bingoEvent selected to true
        
        //getting the index path of selected row
        let indexPath = tableView.indexPathForSelectedRow
        
        //getting the current cell from the index path
        let currentCell = tableView.cellForRow(at: indexPath!)! as! BingoEventTableViewCell
        //getting the text of that cell
        let currentItem = currentCell.eventLbl.text
        let bingoEvent = bingoEvents[(indexPath?.row)!]
        let alertController = UIAlertController(title: "Bingo event selected!", message: "You Selected " + currentItem! , preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BingoEvent")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if(data.value(forKey: "id") as? String == bingoEvent.id) {
                    data.setValue(true, forKey: "selected")
                }
                do {
                    try context.save()
                } catch {
                    print("Failed saving")
                }
            }
            
        } catch {
            
            print("Failed")
        }
        
        currentCell.eventLbl.textColor = UIColor.red
        
    }
    
//    private func loadGameEvents() {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "BingoEvent", in: context)
//        let newGameEvent = NSManagedObject(entity: entity!, insertInto: context)
//        newGameEvent.setValue("Robert Farmer", forKey: "player")
//        newGameEvent.setValue("Slashing penalty", forKey: "type")
//        newGameEvent.setValue("1/2/3", forKey: "period")
//        newGameEvent.setValue("1", forKey: "id")
//        newGameEvent.setValue(fixture?.id, forKey: "fixtureID")
//        let newGameEvent2 = NSManagedObject(entity: entity!, insertInto: context)
//        newGameEvent2.setValue("Steve Lee", forKey: "player")
//        newGameEvent2.setValue("Cross check penalty", forKey: "type")
//        newGameEvent2.setValue("1/2", forKey: "period")
//        newGameEvent2.setValue("2", forKey: "id")
//        newGameEvent2.setValue(fixture?.id, forKey: "fixtureID")
//        do {
//            try context.save()
//        } catch {
//            print("Failed saving")
//        }
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadGameEvents()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BingoEvent")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let bingoEvent = BingoEventItem(type: data.value(forKey: "type") as! String, player: data.value(forKey: "player") as! String, period: data.value(forKey: "period") as! String, id: data.value(forKey: "id") as! String, fixtureID: data.value(forKey: "fixtureID") as! String, selected: data.value(forKey: "selected") as! Bool)
                print(bingoEvent.type)
                bingoEvents += [bingoEvent]
            }
            
        } catch {
            
            print("Failed")
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     super.prepare(for: segue, sender: sender)
     switch(segue.identifier ?? "") {
     case "AddBingoEvent":
        let destinationNavigationController = segue.destination as! UINavigationController
        let addBingoEventViewController = destinationNavigationController.topViewController as? AddBingoEventViewController
        
         //send over the current fixture
        addBingoEventViewController?.fixture = fixture
     
     default:
     fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
     }
     }
    
    @IBAction func unwindToBingoList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddBingoEventViewController, let bingoEvent = sourceViewController.bingoEvent {
            
            let newIndexPath = IndexPath(row: bingoEvents.count, section: 0)
            
            bingoEvents.append(bingoEvent)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "BingoEvent", in: context)
            let newBingoEvent = NSManagedObject(entity: entity!, insertInto: context)
            newBingoEvent.setValue(bingoEvent.player, forKey: "player")
            newBingoEvent.setValue(bingoEvent.type, forKey: "type")
            newBingoEvent.setValue(bingoEvent.period, forKey: "period")
            //id
            newBingoEvent.setValue("1", forKey: "id")
            //fixture id
            newBingoEvent.setValue(fixture?.id, forKey:"fixtureID")
            newBingoEvent.setValue(false, forKey: "selected")
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
        }
    }
    

}
