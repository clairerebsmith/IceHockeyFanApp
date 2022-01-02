//
//  BuySOHBViewController.swift
//  FYP
//
//  Created by Project  on 28/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import CoreData
import os.log

class BuySOHBViewController: UIViewController {

    @IBOutlet weak var numberLbl: UILabel!
    var quantity: Int = 1
    var tickets: [TicketSOHBItem] = []
    var fixture: FixtureItem?
    var currentUser: UserItem?
    @IBOutlet weak var buyButton: UIBarButtonItem!
    @IBAction func addTicket(_ sender: UIButton) {
        quantity += 1
        numberLbl.text = String(quantity)
    }
    @IBAction func minusTicket(_ sender: UIButton) {
        quantity -= 1
        numberLbl.text = String(quantity)
    }
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            print("Num: ", num)
            var count = 0
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TicketSOHB")
            request.returnsObjectsAsFaults = false
            do {
                let result = try context.fetch(request)
                for data in result as! [NSManagedObject] {
                    if data.value(forKey: "owner") as? String == currentUser?.id && data.value(forKey: "fixtureID")as? String == fixture?.id {
                        count = count + 1
                        print("Count: ", count)
                    }
                }
            } catch {
                print("Failed")
            }
            count = count + 1
            print("Final count: ", count)
            let owner = (currentUser?.id)
            let fixtureID = (fixture?.id)
            let entity = NSEntityDescription.entity(forEntityName: "TicketSOHB", in: context)
            let newTicket = NSManagedObject(entity: entity!, insertInto: context)
            newTicket.setValue(String(count), forKey: "id")
            newTicket.setValue(owner, forKey: "owner")
            newTicket.setValue(fixtureID, forKey: "fixtureID")
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
        }
    }
    

}
