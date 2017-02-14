//
//  VictimCell.swift
//  DeathNote
//
//  Created by luc Casimir on 13/02/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import UIKit

class VictimCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!{
        didSet{
            detailLabel.numberOfLines = 0
        }
    }
    
    func setup(withVictim aVictim: Victim)
    {
        nameLabel?.text = aVictim.name
        dateLabel?.text = aVictim.getDate
        detailLabel?.text = aVictim.getDetails
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
