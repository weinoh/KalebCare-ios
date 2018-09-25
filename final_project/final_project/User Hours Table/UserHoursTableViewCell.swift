//
//  UserHoursTableViewCell.swift
//  final_project
//
//  Created by Adam Weintraut on 5/9/18.
//  Copyright © 2018 Adam Weintraut. All rights reserved.
//

import UIKit

class UserHoursTableViewCell: UITableViewCell {

    @IBOutlet weak var UserHoursView: UIView!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var HoursLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
