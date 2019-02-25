//
//  MenuElementCell.swift
//  GuiaUnam
//
//  Created by Axel Cervantes on 1/14/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit

class MenuElementCell: UITableViewCell {
    
    //@IBOutlet weak var menuElementImageView: UIImageView!
    @IBOutlet weak var menuElementNameLabel: UILabel?
    @IBOutlet weak var descriptionMenuElementLabel: UILabel?
    
    @IBOutlet weak var usernameLabel: UILabel?
    @IBOutlet weak var profileImage: UIImageView?
    func configureMenuElement(_ menuElement: MenuElement) {
        if let name = menuElement.name{
            menuElementNameLabel?.text = name
            descriptionMenuElementLabel?.text = menuElement.description!
        }
        else{
            if let userName = menuElement.userName{
                 profileImage?.image = menuElement.profileImage!
                 usernameLabel?.text = userName
            }
        }
        
    }
    
}
