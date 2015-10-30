//
//  CandyDetailViewController.swift
//  candyKilljoy
//
//  Created by Amelia Johnston on 10/29/15.
//  Copyright © 2015 Amelia. All rights reserved.
//

import UIKit

class CandyDetailViewController: UIViewController {

    @IBOutlet weak var candyDetailNameLabel: UILabel!
    
    @IBOutlet weak var candyCaloriesLabel: UILabel!
    
    var candyDetail = Candy?()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tbvc = self.tabBarController as? CandyTabBarViewController
        candyDetail = tbvc!.candyDetail
        
        candyDetailNameLabel.text = candyDetail?.name
        if let candyCalorieCount = candyDetail?.calories {
            candyCaloriesLabel.text = String(candyCalorieCount) + " calories"
        }

    }

    
}
