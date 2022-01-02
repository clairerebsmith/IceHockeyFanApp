//
//  AddTeamViewController.swift
//  FYP
//
//  Created by Project  on 06/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import os.log

class AddTeamViewController: UIViewController {
    
    var team: TeamItem? = nil

    @IBOutlet weak var teamNameInput: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = teamNameInput.text ?? ""
        
        team = TeamItem(name: name)
    }

}
