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
    
    func saveURLHistory(_ urlHistory: HistoryURLEntity) {
      /*  let historyURLEntity = NSEntityDescription.insertNewObject(forEntityName: "HistoryURLEntity", into: appDelegate.managedObjectContext) as! HistoryURLEntity
        historyURLEntity.pageTitle = urlHistory.pageTitle
        historyURLEntity.urlString = urlHistory.urlString
        
        do {
            try appDelegate.managedObjectContext.save()

        }
     */   
    }
    
}
