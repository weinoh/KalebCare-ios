//
//  NavigationController.swift
//  final_project
//
//  Created by Adam Weintraut on 4/28/18.
//  Copyright © 2018 Adam Weintraut. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Avenir Next", size: 20)!, NSAttributedStringKey.foregroundColor: UIColor(red:255/255, green:255/255, blue: 255/255, alpha: 1)]
        self.navigationBar.isTranslucent = true
        self.navigationBar.tintColor = UIColor(red:255/255, green:255/255, blue: 255/255, alpha: 1)
        //self.navigationBar.barTintColor = UIColor(red:18/255, green:4/255, blue: 51/255, alpha: 0.1)
        self.view.backgroundColor = .clear
       // navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Chalkduster", size: 20)!], for: UIControlState.normal)
        //self.navigationBar.barTintColor = UIColor(patternImage: UIImage(named: "loginbackground.jpg")!)
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
