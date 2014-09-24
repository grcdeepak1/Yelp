//
//  PopularCell.swift
//  Yelp
//
//  Created by Deepak on 9/23/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class PopularCell: UITableViewCell {

    @IBOutlet var switchControl: UISwitch!
    @IBOutlet var popularLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPopularCell (labelContent: String)->Void{
        popularLabel.text = labelContent
    }

}
