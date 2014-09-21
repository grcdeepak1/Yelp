//
//  ViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var client: YelpClient!
    var yelpbusinesses = [YelpBusiness]()
    @IBOutlet var tableView: UITableView!
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
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.rowHeight = UITableViewAutomaticDimension
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithTerm("Thai", success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            //println(response)
            let json = JSON(response)
            for (i, j) in json["businesses"] {
                self.yelpbusinesses.append(YelpBusiness(fromJson: j))
            }
            self.tableView.reloadData()
            
        }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            println(error)
        }
        prepareSearchBar()
    
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yelpbusinesses.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("yelpCell") as yelpCell
        let business = yelpbusinesses[indexPath.row]
        cell.updateCell(business, number: indexPath.row + 1)
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func prepareSearchBar(){
        
        var searchBar = UISearchBar(frame: CGRectMake(0.0, 0.0, 300, 44.0))
        searchBar.autoresizingMask = UIViewAutoresizing.FlexibleRightMargin
        searchBar.backgroundColor = UIColor.clearColor()
        self.navigationItem.titleView = searchBar
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()
        
        var filterButton = UIButton(frame: CGRectMake(0, 0, 50.0, 44.0))
        filterButton.setTitle("Filters", forState: UIControlState.Normal)
        filterButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 14.0)
        filterButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        filterButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
        
        let leftHackItem = UIBarButtonItem(customView: filterButton)
        self.navigationItem.leftBarButtonItem = leftHackItem
        
        var emptyView = UIView(frame: CGRectMake(0, 0, 40.0, 44.0))
        let rightHackItem = UIBarButtonItem(customView: emptyView)
        self.navigationItem.rightBarButtonItem = rightHackItem

        
    }
    
}

