//
//  HistoryNaviViewController.swift
//  WebBrowser
//
//  Created by Alexsander Khitev on 9/13/16.
//  Copyright © 2016 Alexsander Khitev. All rights reserved.
//

import UIKit

class HistoryNaviViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // ui
        setupUISettings()
        addControllers()
    }
    
    private func setupUISettings() {
        navigationBar.translucent = false
    }
 
    private func addControllers() {
        let historyVC = HistoryViewController()
        viewControllers = [historyVC]
    }
}
