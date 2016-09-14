//
//  HistoryURLEntity+CoreDataProperties.swift
//  WebBrowser
//
//  Created by Alexsander Khitev on 9/13/16.
//  Copyright © 2016 Alexsander Khitev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension HistoryURLEntity {

    @NSManaged var pageTitle: String?
    @NSManaged var urlString: String?
    @NSManaged var date: NSDate?

}
