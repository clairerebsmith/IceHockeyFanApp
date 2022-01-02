//
//  FixtureViewController.swift
//  FYP
//
//  Created by Project  on 02/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import CoreData
import os.log

class FixtureViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Proeprties
    var events: [EventItem] = []
    var fixture: FixtureItem?
    var currentUser: UserItem?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var homeTeamImg: UIButton!
    @IBOutlet weak var awayTeamImg: UIButton!
    
    //MARK: Methods
    private func loadEvents() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Event", in: context)
        let newEvent = NSManagedObject(entity: entity!, insertInto: context)
        newEvent.setValue("1", forKey: "id")
        newEvent.setValue("Penalty", forKey: "type")
        newEvent.setValue("Slashing", forKey: "name")
        newEvent.setValue("Robert Farmer", forKey: "player")
        newEvent.setValue("3:42", forKey: "time")
        newEvent.setValue("1", forKey: "period")
        newEvent.setValue("Nottingham Panthers", forKey: "team")
        newEvent.setValue("1", forKey: "fixtureID")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    //MARK: Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as? EventTableViewCell else {
            fatalError()
        }
        
        let event = events[indexPath.row]
        
        cell.eventLbl.text = event.type
        return cell
    }
    
    //MARK: On Load
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadEvents()
        homeTeamImg.setImage(UIImage(named: (fixture?.homeTeam)!), for: .normal)
        awayTeamImg.setImage(UIImage(named: (fixture?.awayTeam)!), for: .normal)
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
    

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        //switch statement for each segue
        switch(segue.identifier ?? "") {
        //add fixture to segue to allow only events from current fixture
        case "ViewEvent":
            guard let viewEventViewController = segue.destination as? EventViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedEventCell = sender as? EventTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedEventCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedEvent = events[indexPath.row]
            viewEventViewController.event = selectedEvent
        
        case "Bingo":
            guard let bingoViewController = segue.destination as? BingoViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            bingoViewController.fixture = fixture
            bingoViewController.currentUser = currentUser
        
        case "Predictor":
            guard let predictorViewController = segue.destination as? PredictorViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            predictorViewController.fixture = fixture
            
        case "ViewTeam":
            guard let teamViewController = segue.destination as? PlayersTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            let team = TeamItem(name: (fixture?.homeTeam)!)
            teamViewController.team = team
            
        case "ViewAwayTeam":
            guard let teamViewController = segue.destination as? PlayersTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            let team = TeamItem(name: (fixture?.awayTeam)!)
            teamViewController.team = team
        case "5050":
            let destinationNavigationController = segue.destination as! UINavigationController
            //        let targetController = destinationNavigationController.topViewController
            let ticketViewController = destinationNavigationController.topViewController as! Buy5050ViewController
            ticketViewController.fixture = fixture
            ticketViewController.currentUser = currentUser
        case "SOHB":
            let destinationNavigationController = segue.destination as! UINavigationController
            //        let targetController = destinationNavigationController.topViewController
            let ticketViewController = destinationNavigationController.topViewController as! BuySOHBViewController
            ticketViewController.fixture = fixture
            ticketViewController.currentUser = currentUser
        case "Wallet":
            guard let walletViewController = segue.destination as? WalletViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            walletViewController.currentUser = currentUser
            walletViewController.fixture = fixture
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
            
        }

}
    
    @IBAction func unwindToFixture(sender: UIStoryboardSegue) {
        
        
    }

}
