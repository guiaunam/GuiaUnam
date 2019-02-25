//
//  CollectionViewController.swift
//  GuiaUnam
//
//  Created by Axel Cervantes on 1/13/19.
//  Copyright © 2018 Miguel Vicario. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CollectionViewController: UIViewController {
    
    @IBAction func buttonMenuTapped(_ sender: Any) {
        delegate?.toggleLeftPanel?()
    }
    
    var delegate: CollectionViewControllerDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var museums = [Museum]()

    let estimateWidth = 160.0
    let cellMarginSize = 16.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        self.collectionView.register(UINib(nibName: "ItemCell", bundle: nil), forCellWithReuseIdentifier: "ItemCell")

         setupGridView()

         downloadMuseums()
  }
    
    func setupGridView() {
        let flow = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        
        flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
        flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
    }
    
    func downloadMuseums() {
        
        let ref = Database.database().reference()
        ref.child("museos").observe(.value) { (snapshot) in
            
            self.museums.removeAll()
            
            for child in snapshot.children {
                
                let snap = child as! DataSnapshot
                let dict = snap.value as! [String: Any]
                let museumText = dict["nombre"] as! String
                let urlText = dict["url"] as! String
                let detalles = dict["detalles"] as! String
                let image = dict["img"] as! String
                let schedule = dict["horario"] as! String
                let price = dict["precio"] as! String
                let latitude = dict["lat"] as! String
                let longitude = dict["long"] as! String
                let infoImg = dict["infoimg"] as! String
                let museum = Museum(museumText: museumText,
                                    urlText: urlText,
                                    descriptionText: detalles,
                                    imageURL: image,
                                    scheduleText: schedule,
                                    priceText: price,
                                    latitudeText: latitude,
                                    longitudeText: longitude,
                                    infoImgText: infoImg)
                
                self.museums.append(museum)
                
            }
            
            self.collectionView.reloadData()
            
        }
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "DetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPathSelected = collectionView.indexPathsForSelectedItems?.first else { return }
        if segue.identifier == "DetailSegue"{
            let detailViewData = segue.destination as? InfoViewController
            let museumSelected = museums[indexPathSelected.row]
            detailViewData?.name = museumSelected.museum
            detailViewData?.url = museumSelected.url
            detailViewData?.detail = museumSelected.description
            detailViewData?.schedule = museumSelected.schedule
            detailViewData?.price = museumSelected.price
            detailViewData?.latitude = museumSelected.latitude
            detailViewData?.longitude = museumSelected.longitude
            detailViewData?.infoImg = museumSelected.infoImg
        }
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.museums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        cell.mostRecentURL = self.museums[indexPath.row].image
        cell.setData(imageString: self.museums[indexPath.row].image)
        
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widht = self.calculateWidth()
        
        return CGSize(width: widht, height: widht)
    }
    
    func calculateWidth() -> CGFloat {
        
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount = floor(CGFloat((self.view.frame.size.width) / estimatedWidth))
        
        let margin = CGFloat(cellMarginSize * 2)
        let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        
        return width
    }
}
