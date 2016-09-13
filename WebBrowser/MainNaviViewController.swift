//
//  MainNaviViewController.swift
//  WebBrowser
//
//  Created by Alexsander Khitev on 9/13/16.
//  Copyright © 2016 Alexsander Khitev. All rights reserved.
//

import UIKit

class MainNaviViewController: UINavigationController {
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addControllers()
    }

    private func addControllers() {
        let mainVC = MainViewController()
        viewControllers = [mainVC]
    }
}
