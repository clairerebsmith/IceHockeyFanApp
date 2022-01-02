//
//  ViewPlayerViewController.swift
//  FYP
//
//  Created by Project  on 10/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit
import os.log

class ViewPlayerViewController: UIViewController {
    
    var player: PlayerItem? = nil
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var playerImg: UIImageView!
    @IBOutlet weak var numberLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var teamLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let player = player {
            nameLbl.text = player.name
            playerImg.image = UIImage(named: player.name)
            numberLbl.text = player.number
            ageLbl.text = player.age
            teamLbl.text = player.team
            countryLbl.text = player.country
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
