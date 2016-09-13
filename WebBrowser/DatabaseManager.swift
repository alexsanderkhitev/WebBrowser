//
//  DatabaseManager.swift
//  WebBrowser
//
//  Created by Alexsander Khitev on 9/13/16.
//  Copyright © 2016 Alexsander Khitev. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    func saveURLHistory(urlHistory: HistoryURLEntity) {
        let historyURLEntity = NSEntityDescription.insertNewObjectForEntityForName("HistoryURLEntity", inManagedObjectContext: appDelegate.managedObjectContext) as! HistoryURLEntity
        historyURLEntity.pageTitle = urlHistory.pageTitle
        historyURLEntity.urlString = urlHistory.urlString
        
        do {
            try appDelegate.managedObjectContext.save()

        }
        
    }
    
}