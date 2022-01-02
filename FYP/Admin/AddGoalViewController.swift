//
//  AddGoalViewController.swift
//  FYP
//
//  Created by Project  on 10/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import os.log
import CoreData

class AddGoalViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return teams.count
        } else {
            return players.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return teams[row].name
        } else {
            return players[row].name
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            teamTxtField.text = teams[row].name
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let playerRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
            playerRequest.returnsObjectsAsFaults = false
            do {
                let result = try context.fetch(playerRequest)
                for data in result as! [NSManagedObject] {
                    if data.value(forKey: "team") as? String == teamTxtField.text {
                        let player = PlayerItem(name: data.value(forKey: "name") as! String, number: data.value(forKey: "number") as! String, country: data.value(forKey: "country") as! String, team: data.value(forKey: "team") as! String, age: data.value(forKey: "age") as! String)
                        players += [player]
                    }
                }
                
            } catch {
                
                print("Failed")
            }
        } else {
            playerNameTxtField.text = players[row].name
        }
    }
    
    var event: EventItem? = nil
    var fixture: FixtureItem? = nil
    var period: String = ""
    @IBOutlet weak var playerNameTxtField: UITextField!
    @IBOutlet weak var teamTxtField: UITextField!
    @IBOutlet weak var timeTxtField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var period1Button: UIButton!
    @IBOutlet weak var period2Button: UIButton!
    @IBOutlet weak var period3Button: UIButton!
    var teams: [TeamItem] = []
    var players: [PlayerItem] = []
    
    @IBAction func period1(_ sender: UIButton) {
        period1Button.setBackgroundImage(UIImage(named: "Period1Pressed"), for: .normal)
        period2Button.setBackgroundImage(UIImage(named: "Period2Button"), for: .normal)
        period3Button.setBackgroundImage(UIImage(named: "Period3Button"), for: .normal)
        period = "1"
    }
    @IBAction func period2(_ sender: UIButton) {
        period2Button.setBackgroundImage(UIImage(named: "Period2Pressed"), for: .normal)
        period1Button.setBackgroundImage(UIImage(named: "Period1Button"), for: .normal)
        period3Button.setBackgroundImage(UIImage(named: "Period3Button"), for: .normal)
        period = "2"
    }
    @IBAction func period3(_ sender: UIButton) {
        period = "3"
        period3Button.setBackgroundImage(UIImage(named: "Period3Pressed"), for: .normal)
        period1Button.setBackgroundImage(UIImage(named: "Period1Button"), for: .normal)
        period2Button.setBackgroundImage(UIImage(named: "Period2Button"), for: .normal)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let teamPickerView = UIPickerView()
        teamPickerView.tag = 1
        let playerPickerView = UIPickerView()
        playerPickerView.tag = 2
        
        teams += [TeamItem(name: (fixture?.homeTeam)!), TeamItem(name: (fixture?.awayTeam)!)]
        
        
        
        teamTxtField.inputView = teamPickerView
        playerNameTxtField.inputView = playerPickerView
        
        teamPickerView.delegate = self
        playerPickerView.delegate = self
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        let playerRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
//        playerRequest.returnsObjectsAsFaults = false
//        do {
//            let result = try context.fetch(playerRequest)
//            for data in result as! [NSManagedObject] {
//                if data.value(forKey: "team") as? String == teamTxtField.text {
//                let player = PlayerItem(name: data.value(forKey: "name") as! String, number: data.value(forKey: "number") as! String, country: data.value(forKey: "country") as! String, team: data.value(forKey: "team") as! String, age: data.value(forKey: "age") as! String)
//                players += [player]
//                }
//            }
//
//        } catch {
//
//            print("Failed")
//        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let playerName = playerNameTxtField.text ?? ""
        let teamName = teamTxtField.text ?? ""
        let time = timeTxtField.text ?? ""
        
        var events: [NSManagedObject] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                events += [data]
            }
            
        } catch {
            
            print("Failed")
        }
        
        let count = String(events.count + 1)
        
        event = EventItem(id: count, type: "Goal", name: "", player: playerName, time: time, period: period, team: teamName, fixtureID: fixture!.id)
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
