//
//  ViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    var client: YelpClient!
    var yelpbusinesses = [YelpBusiness]()
    @IBOutlet var tableView: UITableView!
    var searchBar: UISearchBar!
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
        
        fetchDataForSearchTerm("Indian")
        prepareSearchBar()
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - fetchDataForSearchTerm
    func fetchDataForSearchTerm(term: NSString) {
        
        
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithTerm(term, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            //println(response)
            let json = JSON(response)
            self.yelpbusinesses.removeAll(keepCapacity: true)
            for (i, j) in json["businesses"] {
                self.yelpbusinesses.append(YelpBusiness(fromJson: j))
            }
            self.tableView.reloadData()
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yelpbusinesses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("yelpCell") as yelpCell
        let business = yelpbusinesses[indexPath.row]
        cell.updateCell(business, number: indexPath.row + 1)
        return cell
    }
    
    // MARK: - prepareSearchBar
    func prepareSearchBar(){
        
        searchBar = UISearchBar(frame: CGRectMake(0.0, 0.0, 200, 44.0))
        searchBar.delegate = self
        searchBar.autoresizingMask = UIViewAutoresizing.FlexibleRightMargin
        searchBar.backgroundColor = UIColor.clearColor()
        self.navigationItem.titleView = searchBar
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()
        
        /*
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
        */
    }

    // MARK: - UISearchBarDelegate
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        fetchDataForSearchTerm(searchBar.text as NSString)
    }
    //MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var filtersNavigationController = segue.destinationViewController as UINavigationController
        //var filterViewController = filtersNavigationController.viewControllers[0] as filterViewController
        //filterViewController.delegate = self
        
    }
    
}

