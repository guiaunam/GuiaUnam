//
//  SidePanelViewController.swift
//  GuiaUnam
//
//  Created by Axel Cervantes on 1/13/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//
/// Copyright (c) 2017 Razeware LLC
///

import UIKit

class SidePanelViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var menuElements: Array<MenuElement>!
    var identifiersSigned = [String] ()
    var identifiersUnsigned = [String] ()
    
    enum CellIdentifiers {
        static let menuElementCell = "MenuElementCell"
        static let menuElementLoginCell = "MenuElementLoginCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        identifiersSigned = ["User","Favoritos","PorVisitar","Recomendaciones","EventosProximos"]
        identifiersUnsigned = ["IniciarSesion","CercaDeTi"]
        //let identifiersUnsigned = []
        tableView.reloadData()
    }
}

// MARK: Table View Data Source
extension SidePanelViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row != 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.menuElementCell, for: indexPath) as! MenuElementCell
            cell.configureMenuElement(menuElements[indexPath.row])
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.menuElementLoginCell, for: indexPath) as! MenuElementCell
            cell.configureMenuElement(menuElements[indexPath.row])
            return cell
        }
    }
    
    
}

// Mark: Table View Delegate

extension SidePanelViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       /* if indexPath.row == 0{
            performSegue(withIdentifier: "IniciaSesion", sender: nil)
        }*/
        
        if MenuElement.isSignedIn == true{
            let vcName = identifiersSigned[indexPath.row]
            
            let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
            self.navigationController?.pushViewController(viewController!, animated: true)
            
            let navController = UINavigationController(rootViewController: viewController!)
            self.present(navController, animated: true, completion: nil)
            
            
        }
        else{
            let vcName = identifiersUnsigned[indexPath.row]
            
            let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
            self.navigationController?.pushViewController(viewController!, animated: true)
 
            let navController = UINavigationController(rootViewController: viewController!)
            self.present(navController, animated: true, completion: nil)
 
            
        }
        
    }
    
    @objc func backAction() -> Void {
        dismiss(animated: true, completion: nil)
    }
    
}
