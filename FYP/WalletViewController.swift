//
//  WalletViewController.swift
//  FYP
//
//  Created by Project  on 27/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import CoreData

class WalletViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var currentUser: UserItem?
    var fixture: FixtureItem?
    var tickets50: [Ticket50Item] = []
    var ticketsSOHB: [TicketSOHBItem] = []
    
    @IBOutlet weak var tableView50: UITableView!
    @IBOutlet weak var tableViewSOHB: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView50.delegate = self
        tableView50.dataSource = self
        tableViewSOHB.delegate = self
        tableViewSOHB.dataSource = self
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Ticket50")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if data.value(forKey: "owner") as? String == currentUser?.id{
                    print("Owner: ", data.value(forKey: "owner") as? String ?? "")
                    if data.value(forKey: "fixtureID") as? String == fixture?.id {
                        print("FixtureID: ", data.value(forKey: "fixtureID") as? String ?? "")
                        print("ID: ", data.value(forKey: "id") as? String ?? "")
                        let ticket = Ticket50Item(id: data.value(forKey: "id") as! String, owner: data.value(forKey: "owner") as! String, fixtureID: data.value(forKey: "fixtureID") as! String, won: (data.value(forKey: "won") != nil))
                        tickets50 += [ticket]
                    }
                }
            }
            
        } catch {
            
            print("Failed")
        }
        let appDelegateSOHB = UIApplication.shared.delegate as! AppDelegate
        let contextSOHB = appDelegateSOHB.persistentContainer.viewContext
        let requestSOHB = NSFetchRequest<NSFetchRequestResult>(entityName: "TicketSOHB")
        requestSOHB.returnsObjectsAsFaults = false
        do {
            let resultSOHB = try contextSOHB.fetch(requestSOHB)
            for data in resultSOHB as! [NSManagedObject] {
                if data.value(forKey: "owner") as? String == currentUser?.id{
                    //                    print(data.value(forKey: "owner") as? String ?? "")
                    if data.value(forKey: "fixtureID") as? String == fixture?.id {
                        //                        print(data.value(forKey: "fixtureID") as? String ?? "")
                        let ticket = TicketSOHBItem(id: data.value(forKey: "id") as! String, owner: data.value(forKey: "owner") as! String, fixtureID: data.value(forKey: "fixtureID") as! String)
                        ticketsSOHB += [ticket]
                    }
                }
            }
            
        } catch {
            
            print("Failed")
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case self.tableView50:
            return tickets50.count
        case self.tableViewSOHB:
            return ticketsSOHB.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case self.tableView50:
            guard let cell = tableView50.dequeueReusableCell(withIdentifier: "WalletTableViewCell", for: indexPath) as? WalletTableViewCell else {
                fatalError()
            }
            
            let ticket = tickets50[indexPath.row]
            
            cell.idLbl.text = ticket.id
            
            return cell
        case self.tableViewSOHB:
                guard let cell = tableViewSOHB.dequeueReusableCell(withIdentifier: "WalletSOHBTableViewCell", for: indexPath) as? WalletSOHBTableViewCell else {
                    fatalError()
                }
                
                let ticket = ticketsSOHB[indexPath.row]
                
                cell.idLbl.text = ticket.id
                
                return cell
        default:
                guard let cell = tableViewSOHB.dequeueReusableCell(withIdentifier: "WalletTableViewCell", for: indexPath) as? WalletTableViewCell else {
                    fatalError()
                }
                cell.idLbl.text = ""
                return cell
               
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

}
