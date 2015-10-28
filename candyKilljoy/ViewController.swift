//
//  ViewController.swift
//  candyKilljoy
//
//  Created by Amelia Johnston on 10/26/15.
//  Copyright © 2015 Amelia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var candyNameInput: UITextField!
    
    
    
    let BASE_URL = "https://api.nutritionix.com/v1_1/search/"
    let PHRASE = "twizzler"
    //let RESULTS = "0%3A5"
    let APPID = "05fe6213"
    let APPKEY = "cbe02a040321ae45dbfaf44ef0839621"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func candySearchButton(sender: UIButton) {
        
        //TO-DO: must write code to parse search string and put underscores in place of spaces or something like that
        makeAPICall()
    }
    
    
    //MARK: - API Call
    
    func makeAPICall() {
        
        let methodArguments: [String: String!] = [
            "appId": APPID,
            "appKey": APPKEY
        ]
        
        /* 3 - Get the shared NSURLSession to faciliate network activity */
        let session = NSURLSession.sharedSession()
        
        /* 4 - Create the NSURLRequest using properly escaped URL */
        let urlString = BASE_URL + "\(PHRASE)" + escapedParameters(methodArguments)
        //print(urlString)
        let url = NSURL(string: urlString)!
        //print(url)
        let request = NSURLRequest(URL: url)
        print(request)
        
        
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
            
            print(parsedResult)
//            /* GUARD: Did Flickr return an error? */
//            guard let stat = parsedResult["stat"] as? String where stat == "ok" else {
//                print("Flickr API returned an error. See error code and message in \(parsedResult)")
//                return
//            }
            
            /* GUARD: Is "photos" key in our result? */
            guard let candyResults = parsedResult["hits"] as? NSArray else {
                print("Cannot find keys 'hits' in \(parsedResult)")
                return
            }
            print(candyResults.count)
            print("The contents of candy results index 0 is \(candyResults[0])")
            
            for pieceOfCandy in candyResults {
                var candyDetails = pieceOfCandy["fields"]
                var candyName = candyDetails!!["item_name"]
                print(candyName!!)
            }
////            var candyItem = candyResults[0]
//            var candyDetails = candyItem["fields"]
//            var candyName = candyDetails!!["item_name"]
//            print(candyName)
            
    
//            let photoArray = photosDictionary["photo"] as! [[String: AnyObject]]
//            
//            // I'm assuming this is needed to properly update the class variable holding the photo array
//            dispatch_async(dispatch_get_main_queue(), {
//                //self.celebrityPhotoArray =  photoArray
//                //self.randomSelectNextCelebrityPhoto()
//            })
            
            
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
    
    

}

