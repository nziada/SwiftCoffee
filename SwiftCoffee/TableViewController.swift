//
//  TableViewController.swift
//  SwiftCoffee
//
//  Created by Nader Ziada on 2016-04-22.
//  Copyright © 2016 NZ. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var venus = [Venue]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.venus = FoursquarePlaces.getPlaces()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.venus.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "CoffeeShopTableCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CoffeeShopTableCell
        
        // Fetches the appropriate meal for the data source layout.
        let v = self.venus[indexPath.row]
        
        cell.shopName.text = v.name
        cell.address.text = v.address
        cell.distnace.text = "\(v.distance.description) meters away"
        
        return cell
    }
}
