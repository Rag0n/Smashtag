//
//  historySearch.swift
//  Smashtag
//
//  Created by Александр on 21.09.15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import Foundation

class HistorySearch {
    
    var searchHistory: [String] {
        get {
            let defaults = NSUserDefaults.standardUserDefaults()
            if let historyArray = defaults.objectForKey(Constants.historyArrayKey) as? [String] {
                return historyArray
            } else {
                return [String]()
            }
        }
        set {
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(newValue, forKey: Constants.historyArrayKey)
        }
    }
    
    func addSearch(search: String) {
        var historyArray = searchHistory
        if historyArray.count == 100 {
            historyArray.removeLast()
        }
        historyArray.insert(search, atIndex: 0)
        searchHistory = historyArray
    }
    
    private struct Constants {
        static var maxSearches = 100
        static var historyArrayKey = "searchHistory"
    }
}