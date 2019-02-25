//
//  CollectionViewControllerDelegate.swift
//  GuiaUnam
//
//  Created by Miguel Vicario on 1/11/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit

@objc
protocol CollectionViewControllerDelegate {
    @objc optional func toggleLeftPanel()
    @objc optional func collapseSidePanels()
}
