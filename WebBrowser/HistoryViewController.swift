//
//  HistoryViewController.swift
//  WebBrowser
//
//  Created by Alexsander Khitev on 9/13/16.
//  Copyright © 2016 Alexsander Khitev. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // ui
        setupUISettings()
        // settings
        setupSettings()
    }

  
    // MARK: - UI functions
    private func setupUISettings() {
        view.backgroundColor = .whiteColor()
    }
    
    // MARK: - Settings
    private func setupSettings() {
        definesPresentationContext = true
    }



}
