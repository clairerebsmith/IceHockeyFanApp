//
//  EventViewController.swift
//  FYP
//
//  Created by Project  on 02/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {
    
    //MARK: Properties 
    var event: EventItem?
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var playerLbl: UILabel!
    @IBOutlet weak var teamLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var periodLbl: UILabel!
    
    //MARK: On Load
    override func viewDidLoad() {
        super.viewDidLoad()
        if let event = event {
            navigationItem.title = event.type
            nameLbl.text = event.name
            playerLbl.text = event.player
            teamLbl.text = event.team
            periodLbl.text = event.period
            timeLbl.text = event.time
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
