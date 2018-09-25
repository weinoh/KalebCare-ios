//
//  Menu.swift
//  final_project
//
//  Created by Adam Weintraut on 4/24/18.
//  Copyright © 2018 Adam Weintraut. All rights reserved.
//

import Foundation
import UIKit

class Menu {
    var name: String
    var image: UIImage
    
    init?(name: String, image: UIImage? = #imageLiteral(resourceName: "defaultImage")) {
        
        guard !name.isEmpty else {
            return nil
        }
        
        guard let menuImage = image else {
            return nil
        }
        
        self.name = name
        self.image = menuImage
    }
}
