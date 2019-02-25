//
//  InfoViewController.swift
//  GuiaUnam
//
//  Created by Miguel Vicario on 1/11/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import MXParallaxHeader

class InfoViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var horarioLabel: UILabel!
    @IBOutlet weak var precioLabel: UILabel!
    
    @IBOutlet weak var tempExpositionsButton: UIButton!
    @IBOutlet weak var webButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    
    var name = String()
    var url = String()
    var detail = String()
    var schedule = String()
    var price = String()
    var latitude = String()
    var longitude = String()
    var infoImg = String()
    
    var imageView = UIImageView()
    
    var service = ImageService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.gray
        
        scrollView.parallaxHeader.view = imageView
        scrollView.parallaxHeader.mode = MXParallaxHeaderMode.fill
        scrollView.parallaxHeader.minimumHeight = 0
        scrollView.parallaxHeader.height = UIScreen.main.bounds.height * 0.4
        scrollView.flashScrollIndicators()
        
        tempExpositionsButton.layer.cornerRadius = 5
        tempExpositionsButton.layer.masksToBounds = true
        tempExpositionsButton.layer.borderWidth = 1
        tempExpositionsButton.layer.borderColor = UIColor(red: 255, green: 204, blue: 0, alpha: 1).cgColor
        tempExpositionsButton.addTarget(self, action: #selector(tempEventsTransition), for: .touchUpInside)
        
        webButton.layer.cornerRadius = 5
        webButton.layer.masksToBounds = true
        webButton.layer.borderWidth = 1
        webButton.layer.borderColor = UIColor(red: 255, green: 204, blue: 0, alpha: 1).cgColor
        
        mapButton.layer.cornerRadius = 5
        mapButton.layer.masksToBounds = true
        mapButton.layer.borderWidth = 1
        mapButton.layer.borderColor = UIColor(red: 255, green: 204, blue: 0, alpha: 1).cgColor
        
        setData()
        setImage(imageString: infoImg)
    }
    
    func setData() {
        
        self.nameLabel.text = name
        self.descriptionLabel.text = detail
        self.horarioLabel.text = schedule
        self.precioLabel.text = price
    }
    
    func setImage(imageString: String){
        let url = URL(string: imageString)!
        service.load(url: url, completion: { [weak self] (image) in
                self?.imageView.image = image
        })
    }
    
    func openMapForPlace() {
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(Double(latitude) ?? 0, Double(longitude) ?? 0)
        let regionSpan = MKCoordinateRegion(center: coordinates,
                                            latitudinalMeters: regionDistance,
                                            longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "\(self.name)"
        mapItem.openInMaps(launchOptions: options)
    }
    
    @objc func tempEventsTransition(){

        let tempViewController = TemporalEventsViewController(nibName: "TemporalEventsViewController", bundle: nil)
        tempViewController.modalTransitionStyle = .flipHorizontal
        self.present(tempViewController, animated: true, completion: nil)
    }
    
    @IBAction func webAction(_ sender: UIButton) {
        
        guard let url = URL(string: url ) else { return }
        UIApplication.shared.open(url)
    }

    @IBAction func mapAction(_ sender: UIButton) {
        
        openMapForPlace()
    }
}
