//
//  HistoryURLModel.swift
//  WebBrowser
//
//  Created by Alexsander Khitev on 9/14/16.
//  Copyright © 2016 Alexsander Khitev. All rights reserved.
//

import Foundation

class HistoryURLModel {
    
    var pageTitle = ""
    var urlString = ""
    var date = NSDate()
    
    convenience init(pageTitle: String, urlString: String, date: NSDate) {
        self.init()
        self.pageTitle = pageTitle
        self.urlString = urlString
        self.date = date
    }
}
