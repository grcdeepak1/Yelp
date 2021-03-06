//
//  business.swift
//  Yelp
//
//  Created by Deepak on 9/20/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import Foundation
struct YelpBusiness {
    var name            : String?
    var imageURL        : String?
    var address         : NSString?
    var neighborhood    : String?
    var categories      : [String]
    var reviewcount     : Int?
    var ratingImgURL    : String?
    var rating          : Double?
    var distance        : Int?
    var latitude        : Float?
    var longitude       : Float?
    
    init(fromJson json: JSON){
        name = json["name"].asString
        imageURL = json["image_url"].asString
        address = json["location"]["address"][0].asString
        neighborhood = json["location"]["neighborhoods"][0].asString
        
        if let stringLatitude = json["location"]["coordinate"]["latitude"].asString {
            latitude = NSString(string: stringLatitude).floatValue
        }
        
        if let stringLongitude = json["location"]["coordinate"]["longitude"].asString {
            longitude = NSString(string: stringLongitude).floatValue
        }
        
        categories = [String]()
        for (i, j) in json["categories"] {
            if let category = j[0].asString {
                categories.append(category)
            }
        }
        
        reviewcount = json["review_count"].asInt
        ratingImgURL = json["rating_img_url"].asString
        rating = json["rating"].asNumber
        
        if let doubleDistance = json["distance"].asDouble {
            distance = Int(abs(json["distance"].asDouble!))
        }
        
    }
    
    
}