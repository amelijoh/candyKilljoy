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
        candyCaloriesLabel.text = String(candyDetail?.calories)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
