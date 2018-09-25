//
//  MedTableViewCell.swift
//  final_project
//
//  Created by Adam Weintraut on 4/25/18.
//  Copyright © 2018 Adam Weintraut. All rights reserved.
//

import UIKit

protocol ChangeCheckBox{
    func changeCheckBox(done: Bool, index: Int)
}

class MedTableViewCell: UITableViewCell {


    @IBAction func CheckBoxAction(_ sender: UIButton) {
        if tasks![indexP!].done{
            delegate?.changeCheckBox(done: false, index: indexP!)
        }
        else{
            delegate?.changeCheckBox(done: true, index: indexP!)
        }
    }
    @IBOutlet weak var MedLabel: UILabel!
    @IBOutlet weak var DosageLabel: UILabel!
    @IBOutlet weak var MedDetailsLabel: UILabel!
    @IBOutlet weak var MedCellView: UIView!
    @IBOutlet weak var CheckButton: UIButton!
    
    var delegate: ChangeCheckBox?
    var indexP: Int?
    var tasks:[Task]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        MedDetailsLabel.clipsToBounds = true
    }


}
