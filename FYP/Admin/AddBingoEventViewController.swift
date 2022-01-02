//
//  AddBingoEventViewController.swift
//  FYP
//
//  Created by Project  on 20/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import os.log
import CoreData

class AddBingoEventViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return teams.count
        } else if pickerView.tag == 2 {
            return players.count
        } else {
            return types.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return teams[row].name
        } else if pickerView.tag == 2 {
            return players[row].name
        } else {
            return types[row].name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            teamTxtField.text = teams[row].name
        } else if pickerView.tag == 2 {
            playerTxtField.text = players[row].name
        } else {
            typeTxtField.text = types[row].name
        }
    }

    //MARK: Properties
    
    var bingoEvent: BingoEventItem? = nil
    var fixture: FixtureItem? = nil
    var period: String = ""
    @IBOutlet weak var teamTxtField: UITextField!
    @IBOutlet weak var playerTxtField: UITextField!
    @IBOutlet weak var typeTxtField: UITextField!
    @IBOutlet weak var periodTxtField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var period1Button: UIButton!
    @IBOutlet weak var period2Button: UIButton!
    @IBOutlet weak var period3Button: UIButton!
    var team: TeamItem? = nil
    var player: PlayerItem? = nil
    var players: [PlayerItem] = []
    var teams: [TeamItem] = []
    var types: [PenaltyItem] = []
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pickerView = UIPickerView()
        pickerView.tag = 1
        let playerPickerView = UIPickerView()
        playerPickerView.tag = 2
        let typePickerView = UIPickerView()
        typePickerView.tag = 3
        teamTxtField.inputView = pickerView
        playerTxtField.inputView = playerPickerView
        typeTxtField.inputView = typePickerView
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
        let playerRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        playerRequest.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(playerRequest)
            for data in result as! [NSManagedObject] {
                let player = PlayerItem(name: data.value(forKey: "name") as! String, number: data.value(forKey: "number") as! String, country: data.value(forKey: "country") as! String, team: data.value(forKey: "team") as! String, age: data.value(forKey: "age") as! String)
                players += [player]
            }
        } catch {
            print("Failed")
        }
        
        let typeRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Penalty")
        typeRequest.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(typeRequest)
            for data in result as! [NSManagedObject] {
                let type = PenaltyItem(name: data.value(forKey: "name") as! String, desc: data.value(forKey: "desc") as! String, id: data.value(forKey: "id") as! String)
                types += [type]
            }
        } catch {
            print("Failed")
        }
        
        pickerView.delegate = self
        playerPickerView.delegate = self
        typePickerView.delegate = self
    }
    
    
    @IBAction func period1(_ sender: UIButton) {
//        period1Button.isSelected = true;
//        period2Button.isSelected = false;
        period1Button.setBackgroundImage(UIImage(named: "Period1Pressed"), for: .normal)
        period2Button.setBackgroundImage(UIImage(named: "Period2Button"), for: .normal)
        period3Button.setBackgroundImage(UIImage(named: "Period3Button"), for: .normal)
        period = "1"
    }
    
    @IBAction func period2Button(_ sender: UIButton) {
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
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let playerName = playerTxtField.text ?? ""
        let type = typeTxtField.text ?? ""
        
        var bingoEvents: [NSManagedObject] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BingoEvent")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                bingoEvents += [data]
            }
            
        } catch {
            
            print("Failed")
        }
        
        let count = String(bingoEvents.count + 1)
        
        bingoEvent = BingoEventItem(type: type, player: playerName, period: period, id: count, fixtureID: (fixture?.id)!, selected: false)
    }
    
}
