//
//  AddPlayerViewController.swift
//  FYP
//
//  Created by Project  on 26/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import CoreData
import os.log

class AddPlayerViewController: UIViewController {
    
    var team: TeamItem?
    var player: PlayerItem?
    @IBOutlet weak var nameTxtFld: UITextField!
    @IBOutlet weak var numTxtFld: UITextField!
    @IBOutlet weak var countryTxtFld: UITextField!
    @IBOutlet weak var positionTxtFld: UITextField!
    @IBOutlet weak var ageTxtFld: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTxtFld.text ?? ""
        let num = numTxtFld.text ?? ""
        let country = countryTxtFld.text ?? ""
        //let position = positionTxtFld.text ?? ""
        let age = ageTxtFld.text ?? ""
        
//        var events: [NSManagedObject] = []
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
//        request.returnsObjectsAsFaults = false
//        do {
//            let result = try context.fetch(request)
//            for data in result as! [NSManagedObject] {
//                events += [data]
//            }
//
//        } catch {
//
//            print("Failed")
//        }
//
//        let count = String(events.count + 1)
        
        player = PlayerItem(name: name, number: num, country: country, team: "", age: age)
        
    }
    

}
