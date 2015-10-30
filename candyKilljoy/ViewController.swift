//
//  ViewController.swift
//  candyKilljoy
//
//  Created by Amelia Johnston on 10/26/15.
//  Copyright © 2015 Amelia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var candyNameInput: UITextField?
    
    
    var timer = NSTimer()
    var candies: [Candy] = []
    
    let BASE_URL = "https://api.nutritionix.com/v1_1/search/"
    var PHRASE = "twizzler"
    let APPID = "05fe6213"
    let APPKEY = "cbe02a040321ae45dbfaf44ef0839621"
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        PHRASE = "twizzler"
        candyNameInput!.text = ""
       
    }

    @IBAction func candySearchButton(sender: UIButton) {
        
        makeAPICall()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.6, target: self, selector: Selector("startSegue"), userInfo: nil, repeats: false)
    }
    
  
    //MARK: - API Call
    
    func makeAPICall() {
        //If nothing is entered into text field, "Twizzlers" will be the item searched.  Otherwise, entered text will be searched
        if candyNameInput!.text != "" {
            PHRASE = APIFormatter.formatSearchString(candyNameInput!.text!)
        }
        
        let methodArguments: [String: String!] = [
            "appId": APPID,
            "appKey": APPKEY
        ]
        
        /* 3 - Get the shared NSURLSession to faciliate network activity */
        let session = NSURLSession.sharedSession()
        
        /* 4 - Create the NSURLRequest using properly escaped URL */
        let urlString = BASE_URL + "\(PHRASE)" + escapedParameters(methodArguments) + "&fields=item_name%2Cbrand_name%2Citem_id%2Cbrand_id%2Cnf_calories"
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)
        
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                print("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                if let response = response as? NSHTTPURLResponse {
                    print("Your request returned an invalid response! Status code: \(response.statusCode)!")
                } else if let response = response {
                    print("Your request returned an invalid response! Response: \(response)!")
                } else {
                    print("Your request returned an invalid response!")
                }
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                print("No data was returned by the request!")
                return
            }
            
            /* Parse the data! */
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! [String : AnyObject]
            } catch {
                parsedResult = nil
                print("Could not parse the data as JSON: '\(data)'")
                return
            }
          
            
            /* GUARD: Is "hits" key in our result? */
            guard let candyResults = parsedResult["hits"] as? NSArray else {
                print("Cannot find keys 'hits' in \(parsedResult)")
                return
            }
        
            var myCandies: [Candy] = []
            
            for pieceOfCandy in candyResults {
                let newCandy = Candy()
                let candyDetails = pieceOfCandy["fields"]
                let candyName = candyDetails!!["item_name"]
                let candyCalories = candyDetails!!["nf_calories"]
                newCandy.name = candyName as! String
                newCandy.calories = candyCalories as! Int
                myCandies.append(newCandy)
            }

            dispatch_async(dispatch_get_main_queue(), {
                self.candies = myCandies
                
            })
        }
        task.resume()
    }
        
    
    
    
    
    // MARK: Escape HTML Parameters
    
    func escapedParameters(parameters: [String : AnyObject]) -> String {
        
        var urlVars = [String]()
        
        for (key, value) in parameters {
            
            /* Make sure that it is a string value */
            let stringValue = "\(value)"
            
            /* Escape it */
            let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            
            /* Append it */
            urlVars += [key + "=" + "\(escapedValue!)"]
        }
        return (!urlVars.isEmpty ? "?" : "") + urlVars.joinWithSeparator("&")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showCandyNameSegue" {
            let destVC: CandySearchResultTableViewController = segue.destinationViewController as! CandySearchResultTableViewController
            destVC.candyNameResults = self.candies
        }
    }
    
    func startSegue() {
        
        self.performSegueWithIdentifier("showCandyNameSegue", sender: self)
    }
}

