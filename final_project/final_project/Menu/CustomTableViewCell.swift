//
//  CustomTableViewCell.swift
//  final_project
//
//  Created by Adam Weintraut on 4/25/18.
//  Copyright © 2018 Adam Weintraut. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var mainmenuLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
