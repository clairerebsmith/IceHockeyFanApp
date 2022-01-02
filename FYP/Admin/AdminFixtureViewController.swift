//
//  AdminFixtureViewController.swift
//  FYP
//
//  Created by Project  on 06/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import CoreData
import os.log

class AdminFixtureViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var events: [EventItem] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var homeTeam: UIImageView!
    @IBOutlet weak var awayTeam: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var addPenaltyButton: UIButton!
    @IBOutlet weak var addGoalButton: UIButton!
    @IBOutlet weak var activeLbl: UILabel!
    @IBAction func start(_ sender: UIButton) {
        activeLbl.text = "Active"
        finishButton.isEnabled = true
        startButton.isEnabled = false
        addPenaltyButton.isEnabled = true
        addGoalButton.isEnabled = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Fixture")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let id: String = data.value(forKey: "id") as! String
                
                if id == fixture?.id {
                    fixture?.active = true
                }
            }
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
            
        } catch {
            
            print("Failed")
        }
        
    }
    
    @IBAction func finish(_ sender: UIButton) {
        activeLbl.text = "Finished"
        finishButton.isEnabled = false
        startButton.isEnabled = false
        addPenaltyButton.isEnabled = false
        addGoalButton.isEnabled = false
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Fixture")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let id: String = data.value(forKey: "id") as! String
                
                if id == fixture?.id {
                    fixture?.active = false
                }
            }
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
            
        } catch {
            
            print("Failed")
        }
    }
    @IBAction func deleteFixture(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Fixture")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let id: String = data.value(forKey: "id") as! String
                
                if id == fixture?.id {
                    context.delete(data)
                }
            }
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
            
        } catch {
            
            print("Failed")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    var fixture: FixtureItem? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        activeLbl.text = ""
        tableView.dataSource = self
        tableView.delegate = self
        if let fixture = fixture {
            homeTeam.image = UIImage(named: fixture.homeTeam)
            awayTeam.image = UIImage(named: fixture.awayTeam)
            dateLbl.text = fixture.date
            timelbl.text = fixture.time
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let event = EventItem(id: data.value(forKey: "id") as! String, type: data.value(forKey: "type") as! String, name: data.value(forKey: "name") as! String, player: data.value(forKey: "player") as! String, time: data.value(forKey: "time") as! String, period: data.value(forKey: "period") as! String, team: data.value(forKey: "team") as! String, fixtureID: data.value(forKey: "fixtureID") as! String)
                events += [event]
            }
            
        } catch {
            
            print("Failed")
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as? EventTableViewCell else {
            fatalError()
        }
        
        let event = events[indexPath.row]
        
        cell.eventLbl?.text = event.name
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "AddPenalty":
            os_log("Adding a new penalty.", log: OSLog.default, type: .debug)
            let destinationNavigationController = segue.destination as! UINavigationController
            let addPenaltyController = destinationNavigationController.topViewController as? AddPenaltyViewController
            addPenaltyController?.fixture = fixture
            
        case "ShowPenalty":
            guard let showPenaltyViewController = segue.destination as? ViewEventViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedEventCell = sender as? EventTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedEventCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedEvent = events[indexPath.row]
            showPenaltyViewController.event = selectedEvent
            
        case "AddGoal":
            os_log("Adding a new goal.", log: OSLog.default, type: .debug)
            let destinationNavigationController = segue.destination as! UINavigationController
            let addGoalController = destinationNavigationController.topViewController as? AddGoalViewController
            addGoalController?.fixture = fixture
        
        case "ShowGoal":
        guard let addGoalViewController = segue.destination as? AddGoalViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        guard let selectedEventCell = sender as? EventTableViewCell else {
            fatalError("Unexpected sender: \(String(describing: sender))")
        }
        
        guard let indexPath = tableView.indexPath(for: selectedEventCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        let selectedEvent = events[indexPath.row]
        addGoalViewController.event = selectedEvent
            
        case "Games":
            guard let gamesViewController = segue.destination as? AdminGamesViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            //send over the current fixture
           gamesViewController.fixture = fixture
        
        case "Tickets":
            guard let ticketsViewController = segue.destination as? AdminTicketsViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            //send over the current fixture
            ticketsViewController.fixture = fixture
            
        default:
        fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
    }
    }
 
    
    @IBAction func unwindToEventList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddGoalViewController, let event = sourceViewController.event {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                //update an existing goal
                events[selectedIndexPath.row] = event
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                //update core data
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                let context = appDelegate.persistentContainer.viewContext
//                let entity = NSEntityDescription.entity(forEntityName: "Event", in: context)
                
            } else {
                let newIndexPath = IndexPath(row: events.count, section: 0)
                events.append(event)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                let entity = NSEntityDescription.entity(forEntityName: "Event", in: context)
                let newEvent = NSManagedObject(entity: entity!, insertInto: context)
                newEvent.setValue(event.id, forKey: "id")
                newEvent.setValue(event.type, forKey: "type")
                newEvent.setValue(event.name, forKey: "name")
                newEvent.setValue(event.player, forKey: "player")
                newEvent.setValue(event.team, forKey: "team")
                newEvent.setValue(event.time, forKey: "time")
                newEvent.setValue(event.period, forKey: "period")
                newEvent.setValue(event.fixtureID, forKey: "fixtureID")
                do {
                    try context.save()
                } catch {
                    print("Failed saving")
                }
            }
            
        }
        if let sourceViewController = sender.source as? AddPenaltyViewController, let event = sourceViewController.event {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing penalty.
                events[selectedIndexPath.row] = event
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                //update core data
            }
            else {
                //add a new penalty
                let newIndexPath = IndexPath(row: events.count, section: 0)
                events.append(event)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                let entity = NSEntityDescription.entity(forEntityName: "Event", in: context)
                let newEvent = NSManagedObject(entity: entity!, insertInto: context)
                newEvent.setValue(event.id, forKey: "id")
                newEvent.setValue(event.type, forKey: "type")
                newEvent.setValue(event.name, forKey: "name")
                newEvent.setValue(event.player, forKey: "player")
                newEvent.setValue(event.team, forKey: "team")
                newEvent.setValue(event.time, forKey: "time")
                newEvent.setValue(event.period, forKey: "period")
                newEvent.setValue(event.fixtureID, forKey: "fixtureID")
                do {
                    try context.save()
                } catch {
                    print("Failed saving")
                }
            }
            
            
           
        }
    }

}
