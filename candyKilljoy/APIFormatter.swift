//
//  APIFormatter.swift
//  candyKilljoy
//
//  Created by Student on 10/28/15.
//  Copyright © 2015 Amelia. All rights reserved.
//

import Foundation

class APIFormatter {
    
    //The function removes empty spaces from the search phrase and inserts the proper characters for the API
    static func formatSearchString(stringToSearch: String) -> String {
        var newString = ""
        if stringToSearch.containsString(" ") {
            newString = stringToSearch.stringByReplacingOccurrencesOfString(" ", withString: "%20")
            
        } else { newString = stringToSearch }
        
        return newString
    }
    
    
}