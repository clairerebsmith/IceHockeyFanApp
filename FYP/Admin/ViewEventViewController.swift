//
//  ViewEventViewController.swift
//  FYP
//
//  Created by Project  on 11/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import CoreData

class ViewEventViewController: UIViewController {

    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var playerLbl: UILabel!
    
    var event: EventItem? = nil
    
    @IBAction func deleteEvent(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let id: String = data.value(forKey: "id") as! String
                
                if id == event?.id {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let event = event {
            typeLbl.text = event.type
        }
        print(event?.fixtureID as Any)
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
