//
//  BingoTableViewCell.swift
//  FYP
//
//  Created by Project  on 10/04/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit

class BingoTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var eventLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
