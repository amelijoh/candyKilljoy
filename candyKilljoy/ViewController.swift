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
    let PHRASE = "Peanut Butter Cups"
    let APPID = "8b7e5c3ee11d2b7c21e5d9a563c3ac83"
    let APPKEY = "8b7e5c3ee11d2b7c21e5d9a563c3ac83"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func candySearchButton(sender: UIButton) {
    }
    
    
    //MARK: - API Call
    
    func makeAPICall() {
        
        let methodArguments: [String: String!] = [
            "phrase": PHRASE,
            "appid": APPID,
            "appKey": APPKEY
        ]
        
        
        
    }

}

