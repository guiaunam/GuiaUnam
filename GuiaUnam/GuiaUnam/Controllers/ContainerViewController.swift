//
//  ContainerViewController.swift
//  GuiaUnam
//
//  Created by Axel Cervantes on 1/13/19.
//  Copyright © 2018 Miguel Vicario. All rights reserved.
//

import UIKit
import QuartzCore

class ContainerViewController: UIViewController {
    enum SlideOutState {
        case bothCollapsed
        case leftPanelExpanded
    }
    var collectionNavigationController: UINavigationController!
    var collectionViewController: CollectionViewController!
    
    var currentState: SlideOutState = .bothCollapsed
    var leftViewController: SidePanelViewController?
    let centerPanelExpandedOffset: CGFloat = 60
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewController = UIStoryboard.collectionViewController()
        collectionViewController.delegate = self 
        
        collectionNavigationController = UINavigationController(rootViewController: collectionViewController)
        
        view.addSubview(collectionNavigationController.view)
        addChild(collectionNavigationController)
        collectionNavigationController.didMove(toParent: self)
        
    }
}

extension ContainerViewController: CollectionViewControllerDelegate {
    func toggleLeftPanel() {
        
        
        let notAlreadyExpanded = (currentState != .leftPanelExpanded)
        
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func toggleRightPanel() {
    }
    
    func addLeftPanelViewController() {
        guard leftViewController == nil else { return }
        
        if let vc = UIStoryboard.leftViewController() {
            vc.menuElements = MenuElement.allElementsUnsigned()
            addChildSidePanelController(vc)
            leftViewController = vc
        }
    }
    
    func addChildSidePanelController(_ sidePanelController: SidePanelViewController) {
        
        view.insertSubview(sidePanelController.view, at: 0)
        
        addChild(sidePanelController)
        sidePanelController.didMove(toParent: self)
    }
    
    
    func animateLeftPanel(shouldExpand: Bool) {
        if shouldExpand {
            currentState = .leftPanelExpanded
            animateCenterPanelXPosition(
                targetPosition: collectionNavigationController.view.frame.width - centerPanelExpandedOffset)
            
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { finished in
                self.currentState = .bothCollapsed
                self.willMove(toParent: nil)
                self.leftViewController?.view.removeFromSuperview()
                self.leftViewController?.removeFromParent()
                self.leftViewController = nil
            }
        }
    }
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)? = nil) {
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut, animations: {
                        self.collectionNavigationController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
  
}


private extension UIStoryboard {
    
    static func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }
    
    static func leftViewController() -> SidePanelViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "LeftViewController") as? SidePanelViewController
    }
    
    static func collectionViewController() -> CollectionViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "CollectionViewController") as? CollectionViewController
    }
}
