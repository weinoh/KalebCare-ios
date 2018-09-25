//
//  MedTableDetailsViewController.swift
//  final_project
//
//  Created by Adam Weintraut on 4/29/18.
//  Copyright © 2018 Adam Weintraut. All rights reserved.
//

import UIKit

class MedTableDetailsViewController: UIViewController {

    @IBOutlet weak var MedDetailsView: UIView!
    @IBOutlet weak var MedNameLabel: UILabel!
    @IBOutlet weak var MedDetailsTextView: UITextView!
    @IBOutlet weak var MedDosageLabel: UILabel!
    
    
    var thisMedName:String?
    var thisMedDosage:String?
    var thisMedDetails:String?
    var thisSectionChosen:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView(image: UIImage(named: "loginbackground.jpg"))
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        MedDetailsView.sendSubview(toBack: blurEffectView)
        MedDetailsView.sendSubview(toBack: imageView)
        //MedDetailsView.sendSubview(toBack: blurEffectView)
        // Round edges
        MedDetailsView.layer.cornerRadius = MedDetailsView.frame.height / 5
        
        if let medNameToDisplay = thisMedName{
            MedNameLabel.text = medNameToDisplay
        }
        if let medDosageToDisplay = thisMedDosage{
            MedDosageLabel.text = medDosageToDisplay
        }
        if let medDetailsToDisplay = thisMedDetails{
            MedDetailsTextView.text = medDetailsToDisplay
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
