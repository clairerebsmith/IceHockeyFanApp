//
//  AdminTicketsViewController.swift
//  FYP
//
//  Created by Project  on 26/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit

class AdminTicketsViewController: UIViewController {

    var fixture: FixtureItem?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "View5050":
            guard let ticketsViewController = segue.destination as? View5050TableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            ticketsViewController.fixture = fixture
        case "ViewSOHB":
            guard let ticketsViewController = segue.destination as? ViewSOHBTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            ticketsViewController.fixture = fixture
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    

}
