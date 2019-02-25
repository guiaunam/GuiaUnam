//
//  Museum.swift
//  GuiaUnam
//
//  Created by Miguel Vicario on 1/9/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit
import CoreLocation

struct Museum{
    
    var museum: String
    var url: String
    var description: String
    var image: String
    var schedule: String
    var price: String
    var latitude: String
    var longitude: String
    var infoImg: String
    
    init(museumText: String, urlText: String, descriptionText: String, imageURL: String, scheduleText: String, priceText: String, latitudeText: String, longitudeText: String, infoImgText: String) {
        
        museum = museumText
        url = urlText
        description = descriptionText
        image = imageURL
        schedule = scheduleText
        price = priceText
        latitude = latitudeText
        longitude = longitudeText
        infoImg = infoImgText
    }
    
}
