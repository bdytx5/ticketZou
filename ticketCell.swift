//
//  ticketCell.swift
//  tigerHacks
//
//  Created by Brett Young on 10/14/17.
//  Copyright © 2017 Brett Young. All rights reserved.
//

import UIKit

class ticketCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    
    
    
    @IBOutlet weak var userImg: UIImageView!
    
    @IBOutlet weak var opponentImg: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var opponent: UILabel!
    
    @IBOutlet weak var price: UILabel!
    

}
