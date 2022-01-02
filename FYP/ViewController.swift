//
//  ViewController.swift
//  FYP
//
//  Created by Project  on 02/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    //////MARK: Properties//////
    var users: [UserItem] = []
    var user: UserItem?
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    //////Mark: Methods//////
    @IBAction func login(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if usernameTxtField.text == data.value(forKey: "email") as? String
                {
                    if passwordTxtField.text == data.value(forKey: "password") as? String
                    {
                        
                        let email = data.value(forKey: "email") as? String
                        let password = data.value(forKey: "password") as? String
                        let id = data.value(forKey: "id") as? String
                        let name = data.value(forKey: "name") as? String
                        
                        user = UserItem(email: email!, password: password!, name: name!, id: id!)
                        performSegue(withIdentifier: "Login", sender: self)
                    }
                }
            }
        } catch {
            print("Failed")
        }
    }
    
    //////MARK: On Load //////
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPenalties()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue("claire@hotmail.com", forKey: "email")
        newUser.setValue("Hello1234", forKey: "password")
        newUser.setValue("Claire Smith", forKey: "name")
        newUser.setValue("1", forKey: "id")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }

    /////// MARK: - Navigation//////
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "Login" {
            let destinationNavigationController = segue.destination as! UINavigationController
            //        let targetController = destinationNavigationController.topViewController
            let targetController = destinationNavigationController.topViewController as! HomeTableViewController
            targetController.currentUser = user
        }
        
    }
    
    func loadPenalties() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Penalty", in: context)
        let slashing = NSManagedObject(entity: entity!, insertInto: context)
        slashing.setValue("Slashing", forKey: "name")
        slashing.setValue("Called for swinging the stick at an opponent. ", forKey: "desc")
        slashing.setValue("1", forKey: "id")
        let charging = NSManagedObject(entity: entity!, insertInto: context)
        charging.setValue("Charging", forKey: "name")
        charging.setValue("Called for taking three or more strides before checking an opponent.", forKey: "desc")
        charging.setValue("2", forKey: "id")
        let crossChecking = NSManagedObject(entity: entity!, insertInto: context)
        crossChecking.setValue("Cross Checking", forKey: "name")
        crossChecking.setValue("Called for hitting opponent with both hands on the stick and no part of the stick on the ice. ", forKey: "desc")
        crossChecking.setValue("3", forKey: "id")
        //            let boarding = NSManagedObject(entity: entity!, insertInto: context)
        //            boarding.setValue("Boarding", forKey: "name")
        //            boarding.setValue("Called for any action which cause the opponent to be thrown violently into the boards. ", forKey: "desc")
        //            boarding.setValue("4", forKey: "id")
        //            let delayed = NSManagedObject(entity: entity!, insertInto: context)
        //            delayed.setValue("Delayed", forKey: "name")
        //            delayed.setValue("Call is made when the penalized team gains control of the puck or upon a stop in play. ", forKey: "desc")
        //            delayed.setValue("5", forKey: "id")
        //            let elbowing = NSManagedObject(entity: entity!, insertInto: context)
        //            elbowing.setValue("Elbowing", forKey: "name")
        //            elbowing.setValue("Called when using the elbow to impede an opponent. ", forKey: "desc")
        //            elbowing.setValue("6", forKey: "id")
        //            let holding = NSManagedObject(entity: entity!, insertInto: context)
        //            holding.setValue("Holding", forKey: "name")
        //            holding.setValue("Called for using the hands, arms or legs to hold an opponent. ", forKey: "desc")
        //            holding.setValue("7", forKey: "id")
        //            let hooking = NSManagedObject(entity: entity!, insertInto: context)
        //            hooking.setValue("Hooking", forKey: "name")
        //            hooking.setValue("Called for using stick or blade to hook an opponent and slow them down. ", forKey: "desc")
        //            hooking.setValue("8", forKey: "id")
        //            let interferance = NSManagedObject(entity: entity!, insertInto: context)
        //            interferance.setValue("Interferance", forKey: "name")
        //            interferance.setValue("Called for having contact with the opponent not in possession of the puck. ", forKey: "desc")
        //            interferance.setValue("9", forKey: "id")
        //            let misconduct = NSManagedObject(entity: entity!, insertInto: context)
        //            misconduct.setValue("Misconduct", forKey: "name")
        //            misconduct.setValue("Called for an interaction that warrants a more serious penalty than a standard minor penalty. ", forKey: "desc")
        //            misconduct.setValue("10", forKey: "id")
        //            let roughing = NSManagedObject(entity: entity!, insertInto: context)
        //            roughing.setValue("Roughing", forKey: "name")
        //            roughing.setValue("Called for engaging in fisticuffs or shoving if a level that is not worthy of a major penalty. ", forKey: "desc")
        //            roughing.setValue("11", forKey: "id")
        //            let spearing = NSManagedObject(entity: entity!, insertInto: context)
        //            spearing.setValue("Spearing", forKey: "name")
        //            spearing.setValue("Called for using the stick like a spear. ", forKey: "desc")
        //            spearing.setValue("12", forKey: "id")
        //            let tripping = NSManagedObject(entity: entity!, insertInto: context)
        //            tripping.setValue("Tripping", forKey: "name")
        //            tripping.setValue("Called for using the stick, arm or leg to cause an opponent to fall. ", forKey: "desc")
        //            tripping.setValue("13", forKey: "id")
        //            let brokenStick = NSManagedObject(entity: entity!, insertInto: context)
        //            brokenStick.setValue("Broken Stick", forKey: "name")
        //            brokenStick.setValue("", forKey: "desc")
        //            brokenStick.setValue("14", forKey: "id")
        //            let highStick = NSManagedObject(entity: entity!, insertInto: context)
        //            highStick.setValue("High-Stick", forKey: "name")
        //            highStick.setValue("Called for making contact with an opponent when carrying the stick above the shoulder. ", forKey: "desc")
        //            highStick.setValue("15", forKey: "id")
        //            let unsportsmanlike = NSManagedObject(entity: entity!, insertInto: context)
        //            unsportsmanlike.setValue("Unsportsmanlike conduct", forKey: "name")
        //            unsportsmanlike.setValue("Called for the abuse of an official or other such misconduct. ", forKey: "desc")
        //            unsportsmanlike.setValue("16", forKey: "id")
        //            let fighting = NSManagedObject(entity: entity!, insertInto: context)
        //            fighting.setValue("Fighting", forKey: "name")
        //            fighting.setValue("Engaging in  physical altercation with an opposing player. ", forKey: "desc")
        //            fighting.setValue("17", forKey: "id")
        //            let goaltenderI = NSManagedObject(entity: entity!, insertInto: context)
        //            goaltenderI.setValue("Goaltender Inerference", forKey: "name")
        //            goaltenderI.setValue("Physically impeding or checking the goaltender. ", forKey: "desc")
        //            goaltenderI.setValue("18", forKey: "id")
        //            let tooManyMen = NSManagedObject(entity: entity!, insertInto: context)
        //            tooManyMen.setValue("Too many men", forKey: "name")
        //            tooManyMen.setValue("Having more than allowable number of players on the ice. ", forKey: "desc")
        //            tooManyMen.setValue("19", forKey: "id")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    
}

