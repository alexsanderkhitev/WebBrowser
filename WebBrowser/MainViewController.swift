//
//  MainViewController.swift
//  WebBrowser
//
//  Created by Alexsander Khitev on 9/13/16.
//  Copyright © 2016 Alexsander Khitev. All rights reserved.
//

import UIKit
import WebKit

class MainViewController: UIViewController, UIWebViewDelegate, UISearchBarDelegate {
    
    // MARK: - UI Elements 
    private let toolBar = UIToolbar()
    private var prerviousWebButton = UIBarButtonItem()
    private var nextWebButton = UIBarButtonItem()
    private var webView = UIWebView()
    private lazy var searchBar = UISearchBar()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // ui
        addUIElements()
        createToolBarSettings()
        createSearchBar()
        setupUISettings()
        // settings 
        setupSettings()
        setupWebViewSettings()
    }

    // MARK: - Override functions 
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupUIElementsPositions()
    }
    
    // MARK: - UI functions 
    private func addUIElements() {
        view.addSubview(toolBar)
        view.addSubview(webView)
    }
    
    private func setupUIElementsPositions() {
        toolBar.frame = CGRect(x: 0, y: view.frame.height - 44, width: view.frame.width, height: 44)
        webView.frame = CGRect(x: 0, y: 44, width: view.frame.width, height: view.frame.height - 88)
    }
    
    private func createToolBarSettings() {
        prerviousWebButton = UIBarButtonItem(title: "<-", style: .Plain, target: self, action: #selector(previousPageAction))
        nextWebButton = UIBarButtonItem(title: "->", style: .Plain, target: self, action: #selector(nextPageAction))
        let firstFixedSpace = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        firstFixedSpace.width = 20
        toolBar.items = [prerviousWebButton, firstFixedSpace, nextWebButton]
        
        // settings 
        enableWebBrowsingButton(false)
    }
    
    private func setupUISettings() {
        view.backgroundColor = .whiteColor()
    }
    
    // MARK: Search bar
    private func createSearchBar() {
        navigationItem.titleView = searchBar
        searchBar.autocapitalizationType = .None
        searchBar.keyboardType = .WebSearch
        searchBar.showsCancelButton = true
        searchBar.delegate = self
    }
    
    // MARK: - Settings 
    private func setupSettings() {
        definesPresentationContext = true
    }

    // MARK: - Controllers 
    private func enableWebBrowsingButton(bool: Bool) {
        prerviousWebButton.enabled = bool
        nextWebButton.enabled = bool
    }

    // MARK: - WebBrowser functions 
    private func setupWebViewSettings() {
        webView.delegate = self
        webView.userInteractionEnabled = false
    }
    
    @objc private func previousPageAction() {
        
    }
    
    @objc private func nextPageAction() {
        
    }
    
    // MARK: - SearchBar Delegate
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
