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
    
    fileprivate let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func saveURLHistory(_ urlHistory: HistoryURLModel) {
        let managedObjectContext = appDelegate.managedObjectContext
        let historyURLEntity = NSEntityDescription.insertNewObject(forEntityName: "HistoryURLEntity", into: managedObjectContext) as! HistoryURLEntity
        print("urlHistory.pageTitle", urlHistory.pageTitle, urlHistory.date)
        historyURLEntity.pageTitle = urlHistory.pageTitle
        historyURLEntity.urlString = urlHistory.urlString
        historyURLEntity.date = urlHistory.date
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}
