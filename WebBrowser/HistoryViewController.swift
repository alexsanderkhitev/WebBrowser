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
    fileprivate let tableView = UITableView(frame: CGRect.zero, style: .plain)
    
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
    fileprivate func addUIElements() {
        view.addSubview(tableView)
    }
    
    fileprivate func setupUIElementsPositions() {
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    
    fileprivate func createButtons() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dissmiss))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    fileprivate func setupUISettings() {
        view.backgroundColor = .white
    }
    
    // MARK: - Settings
    fileprivate func setupSettings() {
        definesPresentationContext = true
    }

    // MARK: - Table view
    fileprivate func setupTableViewSettings() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    // MARK: - Navigation
    @objc fileprivate func dissmiss() {
        dismiss(animated: true, completion: nil)
    }
}
