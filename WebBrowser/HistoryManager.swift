//
//  HistoryManager.swift
//  WebBrowser
//
//  Created by Alexsander Khitev on 9/15/16.
//  Copyright © 2016 Alexsander Khitev. All rights reserved.
//

import Foundation

@objc protocol HistoryManagerDelegate {
    @objc optional func didSelectHistory(history: HistoryURLEntity)
}

class HistoryManager {
    
    static let shared = HistoryManager()
    
    weak var delegate: HistoryManagerDelegate?
    
    func didSelectHistory(history: HistoryURLEntity) {
        delegate?.didSelectHistory?(history: history)
    }
    
}
