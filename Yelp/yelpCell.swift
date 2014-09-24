//
//  yelpCell.swift
//  Yelp
//
//  Created by Deepak on 9/20/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class yelpCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numReviewLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var starsImageView: UIImageView!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateCell(business : YelpBusiness, number: Int) {
        var categoryString : NSString = ""
        nameLabel.text = "\(number). \(business.name!)"
        addressLabel.text = "\(business.address?), \(business.neighborhood?)"
        numReviewLabel.text = "\(business.reviewcount!) Reviews"
        for eachCataegory in business.categories {
            if(categoryString != "") {
                categoryString = categoryString + ", "+eachCataegory
            } else {
                categoryString = categoryString + eachCataegory
            }
        }
        categoryLabel.text = categoryString
        //distanceLabel.text = "\(business.distance)" + " miles"
        starsImageView.setImageWithURL(NSURL(string: business.ratingImgURL!))
        posterImageView.setImageWithURLRequest(
            NSURLRequest(URL: NSURL(string: business.imageURL!)),
            placeholderImage: nil,
            success: { (request: NSURLRequest!, response: NSHTTPURLResponse!, image: UIImage!) in
                self.posterImageView.alpha = 0.0
                self.posterImageView.image = image
                UIView.animateWithDuration(0.5, animations: {self.posterImageView.alpha = 1.0})
            },
            failure: { (request: NSURLRequest!, response: NSHTTPURLResponse!, error: NSError!) in
                println("Image failed to load")
        })
    }
}
