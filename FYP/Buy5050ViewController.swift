//
//  Buy5050ViewController.swift
//  FYP
//
//  Created by Project  on 26/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import os.log
import CoreData

class Buy5050ViewController: UIViewController {

    var quantity: Int = 1
    var tickets: [Ticket50Item] = []
    var fixture: FixtureItem?
    var currentUser: UserItem?
    @IBOutlet weak var numberLbl: UILabel!
    @IBOutlet weak var buyButton: UIBarButtonItem!
    
    @IBAction func addTicket(_ sender: UIButton) {
        
        quantity += 1
        numberLbl.text = String(quantity)
    }
    
    @IBAction func minusTicket(_ sender: UIButton) {
        quantity -= 1
        numberLbl.text = String(quantity)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === buyButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        for num in 1 ..< quantity+1 {
//            print("Num: ", num)
            var count = 0
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Ticket50")
            request.returnsObjectsAsFaults = false
            do {
                let result = try context.fetch(request)
                for data in result as! [NSManagedObject] {
                    if data.value(forKey: "owner") as? String == currentUser?.id && data.value(forKey: "fixtureID")as? String == fixture?.id {
                        count = count + 1
//                        print("Count: ", count)
                    }
                }
            } catch {
                print("Failed")
            }
            count = count + 1
//            print("Final count: ", count)
            let owner = (currentUser?.id)
            let fixtureID = (fixture?.id)
            let entity = NSEntityDescription.entity(forEntityName: "Ticket50", in: context)
            let newTicket = NSManagedObject(entity: entity!, insertInto: context)
            newTicket.setValue(String(count), forKey: "id")
            newTicket.setValue(owner, forKey: "owner")
            newTicket.setValue(fixtureID, forKey: "fixtureID")
            newTicket.setValue(true, forKey: "won")
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
        }
    }
    

}
