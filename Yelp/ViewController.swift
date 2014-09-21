//
//  ViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var client: YelpClient!
    
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    let yelpConsumerKey    = "NwlgK2WdEuPXN5-g6KYTsA"
    let yelpConsumerSecret = "EWFunrsvK2cqiJZ08E__g6ajqBM"
    let yelpToken          = "3bRI-b5gaFIYnh05ZbnwdPFSkB4bq9pQ"
    let yelpTokenSecret    = "mGZE5f3kL-rWIucoYyZTcf2nWCw"
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithTerm("Thai", success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            //println(response)
            var tempArray = response.objectForKey("businesses") as NSArray
            for item in tempArray {
                var itemDictionary = item as NSDictionary
                println(itemDictionary.objectForKey("name") as NSString)
                println(itemDictionary.objectForKey("review_count") as NSNumber)
                var loc = itemDictionary.objectForKey("location") as NSDictionary
                var disAddress = loc.objectForKey("display_address") as NSArray
                var streetAddress = disAddress[0]  as NSString
                var neighborhood = disAddress[1] as NSString
                println(itemDictionary.objectForKey("image_url") as NSString)
                println(itemDictionary.objectForKey("rating_img_url") as NSString)
                println(streetAddress+","+neighborhood)
                var cats = itemDictionary.objectForKey("categories") as NSArray
                var catString = "" as NSString
                for cat in cats {
                    if(catString.length > 0 ) {
                      catString = catString + ", " + (cat[0] as NSString)
                    } else {
                      catString = catString + (cat[0] as NSString)
                    }

                }
                println(catString)
                
                println("--")
            }
            //println(tempArray)
        }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            println(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

