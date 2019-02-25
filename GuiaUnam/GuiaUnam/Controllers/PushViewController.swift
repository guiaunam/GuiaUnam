//
//  pushViewController.swift
//  GuiaUnam
//
//  Created by Axel Cervantes on 2/1/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit

class PushViewController: UIViewController{
    override func viewDidLoad(){
        super.viewDidLoad()
        let backButton = UIBarButtonItem(title: "Regresar", style: .plain, target: self, action: #selector(backAction))
        self.navigationItem.leftBarButtonItem = backButton
    }
    @objc func backAction() -> Void {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
