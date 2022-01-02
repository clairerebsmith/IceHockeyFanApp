//
//  AddFixtureViewController.swift
//  FYP
//
//  Created by Project  on 06/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import os.log
import CoreData

class AddFixtureViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return teams.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return teams[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            homeTeamInput.text = teams[row].name
        } else {
            awayTeamInput.text = teams[row].name
        }
    }
    
    var fixture: FixtureItem? = nil
    var teams: [TeamItem] = []
    @IBOutlet weak var homeTeamInput: UITextField!
    @IBOutlet weak var awayTeamInput: UITextField!
    @IBOutlet weak var dateInput: UITextField!
    @IBOutlet weak var timeInput: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let homePickerView = UIPickerView()
        homePickerView.tag = 1
        let awayPickerView = UIPickerView()
        awayPickerView.tag = 2
        homeTeamInput.inputView = homePickerView
        awayTeamInput.inputView = awayPickerView
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Team")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let team = TeamItem(name: data.value(forKey: "name") as! String)
                teams += [team]
            }
            
        } catch {
            
            print("Failed")
        }
        
        homePickerView.delegate = self
        awayPickerView.delegate = self
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        //switch statement

        
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let homeTeam = homeTeamInput.text ?? ""
        let awayTeam = awayTeamInput.text ?? ""
        let date = dateInput.text ?? ""
        let time = timeInput.text ?? ""
        //get number of current fixtures to give the new fixture an id
        var fixtures: [NSManagedObject] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Fixture")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                fixtures += [data]
            }
            
        } catch {
            
            print("Failed")
        }
        
        let count = String(fixtures.count + 1)
        
        fixture = FixtureItem(id: count, homeTeam: homeTeam, awayTeam: awayTeam, date: date, time: time, active: false)
    }
    

}
