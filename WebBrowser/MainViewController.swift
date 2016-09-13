//
//  MainViewController.swift
//  WebBrowser
//
//  Created by Alexsander Khitev on 9/13/16.
//  Copyright © 2016 Alexsander Khitev. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - UI Elements 
    private let toolBar = UIToolbar()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // ui
        addUIElements()
        setupUISettings()
        // settings 
        setupSettings()
    }

    // MARK: - Override functions 
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupUIElementsPositions()
    }
    
    // MARK: - UI functions 
    private func addUIElements() {
        view.addSubview(toolBar)
    }
    
    private func setupUIElementsPositions() {
        toolBar.frame = CGRect(x: 0, y: view.frame.height - 44, width: view.frame.width, height: 44)
    }
    
    private func setupUISettings() {
        view.backgroundColor = .whiteColor()
    }
    
    // MARK: - Settings 
    private func setupSettings() {
        definesPresentationContext = true
    }



}
