//
//  candySearchResultTableViewController.swift
//  candyKilljoy
//
//  Created by Amelia Johnston on 10/28/15.
//  Copyright © 2015 Amelia. All rights reserved.
//

import UIKit

class CandySearchResultTableViewController: UITableViewController {

    
    var candyNameResults: [Candy] = []
    var selectedCandy: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return candyNameResults.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        let nextCandy = candyNameResults[indexPath.row]
        cell.textLabel?.textColor = UIColor(red: 255/255.0, green: 155/255.0, blue: 34/255.0, alpha:1.0)
        cell.textLabel!.text = nextCandy.name
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedCandy = indexPath.row
        self.performSegueWithIdentifier("candyDetailSegue", sender: indexPath.row)
    }
    

   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! CandyTabBarViewController
        vc.candyDetail = candyNameResults[selectedCandy!]
    }


}
