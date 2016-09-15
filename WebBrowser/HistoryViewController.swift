//
//  HistoryViewController.swift
//  WebBrowser
//
//  Created by Alexsander Khitev on 9/13/16.
//  Copyright © 2016 Alexsander Khitev. All rights reserved.
//

import UIKit
import CoreData


class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    // MARK: - UI elements
    fileprivate let tableView = UITableView(frame: CGRect.zero, style: .plain)
    
    // MARK: - Identifier
    fileprivate let historyCellIdentifier = "historyCellIdentifier"
    
    // MARK: - Controllers
    fileprivate var fetchedResultController: NSFetchedResultsController<HistoryURLEntity>!
    fileprivate let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    // MARK: - Data 
    
    fileprivate var histories = [HistoryURLEntity]()
    
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
        // requests
        requestHistory()
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

    // MARK: - Request functions 
    fileprivate func requestHistory() {
        let managedObjectContext = appDelegate.managedObjectContext
        let fetchRequest: NSFetchRequest = fetchHistoryRequest()
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        do {
            try fetchedResultController.performFetch()
        } catch let error as NSError {
            print(error.localizedDescription)
        }        

        guard let histories = fetchedResultController.fetchedObjects else {
            return
        }
        
        self.histories = histories
        
        print("fetchedResultController.fetchedObjects?.count", histories.count)
        histories.forEach { (history) in
            print(history.pageTitle, history.urlString, history.date)
        }
        
        tableView.reloadData()
    }
    
    fileprivate func fetchHistoryRequest() -> NSFetchRequest<HistoryURLEntity> {
        let fetchRequest = NSFetchRequest<HistoryURLEntity>(entityName: "HistoryURLEntity")
        fetchRequest.fetchLimit = 500
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    
    // MARK: - Table view
    fileprivate func setupTableViewSettings() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: historyCellIdentifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return histories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: historyCellIdentifier, for: indexPath)
        let history = histories[indexPath.row]
        if let pageTitle = history.pageTitle {
            cell.textLabel?.text = pageTitle
        }
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dissmiss()
        let history = histories[indexPath.row]
        HistoryManager.shared.didSelectHistory(history: history)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let removeAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            let history = self.histories[indexPath.row]
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedObjectContext = appDelegate.managedObjectContext
            managedObjectContext.delete(history)
            self.requestHistory()
        }
        return [removeAction]
    }
    

    // MARK: - Navigation
    @objc fileprivate func dissmiss() {
        dismiss(animated: true, completion: nil)
    }
}
