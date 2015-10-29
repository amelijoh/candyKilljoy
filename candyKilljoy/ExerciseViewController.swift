//
//  ExerciseViewController.swift
//  candyKilljoy
//
//  Created by Craig Carlson on 10/29/15.
//  Copyright © 2015 Amelia. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController {

    @IBOutlet weak var run140Label: UILabel!
    @IBOutlet weak var run170Label: UILabel!
    @IBOutlet weak var run200Label: UILabel!
    @IBOutlet weak var run230Label: UILabel!
    
    @IBOutlet weak var cycle140Label: UILabel!
    @IBOutlet weak var cycle170Label: UILabel!
    @IBOutlet weak var cycle200Label: UILabel!
    @IBOutlet weak var cycle230Label: UILabel!
    
    @IBOutlet weak var lift140Label: UILabel!
    @IBOutlet weak var lift170Label: UILabel!
    @IBOutlet weak var lift200Label: UILabel!
    @IBOutlet weak var lift230Label: UILabel!
    
    var candyDetail = Candy?()
    var candyCalorieRetrieved: Double = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let tbvc = self.tabBarController as? CandyTabBarViewController
        candyDetail = tbvc!.candyDetail
        
        if let candyCalorieCount = candyDetail?.calories {
            candyCalorieRetrieved = Double(candyCalorieCount)
            
        }
        print("Our chosen candy has \(candyCalorieRetrieved) calories")
        
        run140Label.text = "Run for \(Double(round(100 * (candyCalorieRetrieved / 10.6))/100)) minutes"
        run170Label.text = "Run for \(Double(round(100 * (candyCalorieRetrieved / 12.8))/100)) minutes"
        run200Label.text = "Run for \(Double(round(100 * (candyCalorieRetrieved / 15.1))/100)) minutes"
        run230Label.text = "Run for \(Double(round(100 * (candyCalorieRetrieved / 17.4))/100)) minutes"
        cycle140Label.text = "Cycle for \(Double(round(100 * (candyCalorieRetrieved / 8.4))/100)) minutes"
        cycle170Label.text = "Cycle for \(Double(round(100 * (candyCalorieRetrieved / 10.3))/100)) minutes"
        cycle200Label.text = "Cycle for \(Double(round(100 * (candyCalorieRetrieved / 12.0))/100)) minutes"
        cycle230Label.text = "Cycle for \(Double(round(100 * (candyCalorieRetrieved / 13.9))/100)) minutes"
        lift140Label.text = "Lift weights for \(Double(round(100 * (candyCalorieRetrieved / 3.1))/100)) minutes"
        lift170Label.text = "Lift weights for \(Double(round(100 * (candyCalorieRetrieved / 3.8))/100)) minutes"
        lift200Label.text = "Lift weights for \(Double(round(100 * (candyCalorieRetrieved / 4.5))/100)) minutes"
        lift230Label.text = "Lift weights for \(Double(round(100 * (candyCalorieRetrieved / 5.2))/100)) minutes"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
