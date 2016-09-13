//
//  HistoryViewController.swift
//  WebBrowser
//
//  Created by Alexsander Khitev on 9/13/16.
//  Copyright © 2016 Alexsander Khitev. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UI elements
    private let tableView = UITableView(frame: CGRectZero, style: .Plain)
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // ui
        addUIElements()
        setupUISettings()
        createButtons()
        // settings
        setupTableViewSettings()
        setupSettings()
    }

    // MARK: - Override functions
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupUIElementsPositions()
    }
  
    // MARK: - UI functions
    private func addUIElements() {
        view.addSubview(tableView)
    }
    
    private func setupUIElementsPositions() {
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    
    private func createButtons() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(dissmiss))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func setupUISettings() {
        view.backgroundColor = .whiteColor()
    }
    
    // MARK: - Settings
    private func setupSettings() {
        definesPresentationContext = true
    }

    // MARK: - Table view
    private func setupTableViewSettings() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    // MARK: - Navigation
    @objc private func dissmiss() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
