//
//  ItemCell.swift
//  GuiaUnam
//
//  Created by Miguel Vicario on 12/29/18.
//  Copyright © 2018 Miguel Vicario. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {


    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var imageCell: UIImageView!
    
    var service = ImageService()
    var mostRecentURL: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loading.isHidden = false
        loading.startAnimating()
        
        imageCell.layer.cornerRadius = 10
        imageCell.layer.masksToBounds = true
    }

    func setData(imageString: String){
        let url = URL(string: imageString)!
        service.load(url: url, completion: { [weak self] (image) in
            if self!.mostRecentURL == imageString {
                self?.imageCell.image = image
            }
            self?.loading.stopAnimating()
            self?.loading.isHidden = true
        })
    }
    
    override func prepareForReuse() {
        loading.isHidden = false
        loading.startAnimating()
        imageCell.image = nil
    }
    
}
