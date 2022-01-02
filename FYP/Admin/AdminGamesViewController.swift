//
//  AdminGamesViewController.swift
//  FYP
//
//  Created by Project  on 20/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit

class AdminGamesViewController: UIViewController {
    
    var fixture: FixtureItem? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "Bingo":
            guard let bingoViewController = segue.destination as? AdminBingoViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            //send over the current fixture
            bingoViewController.fixture = fixture
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }


}
