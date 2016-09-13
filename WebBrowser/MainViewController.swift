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
    private var goBackButton = UIBarButtonItem()
    private var goForwardButton = UIBarButtonItem()
    private var webView = UIWebView()
    private lazy var searchBar = UISearchBar()
    private let activityView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    
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
        setupActivityViewSettings()
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
        webView.addSubview(activityView)
    }
    
    private func setupUIElementsPositions() {
        toolBar.frame = CGRect(x: 0, y: view.frame.height - 44, width: view.frame.width, height: 44)
        webView.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height - 108)
    }
    
    private func createToolBarSettings() {
        goBackButton = UIBarButtonItem(title: "<-", style: .Plain, target: self, action: #selector(webViewGoBack))
        goForwardButton = UIBarButtonItem(title: "->", style: .Plain, target: self, action: #selector(webViewGoForward))
        let firstFixedSpace = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        firstFixedSpace.width = 20
        toolBar.items = [goBackButton, firstFixedSpace, goForwardButton]
        
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
        goBackButton.enabled = bool
        goForwardButton.enabled = bool
    }

    // MARK: - WebBrowser functions 
    private func setupWebViewSettings() {
        webView.delegate = self
        webView.userInteractionEnabled = false
    }
    
    private func webViewSearch(requestString: String) {
        let formattedRequestString = requestString.stringByReplacingOccurrencesOfString(" ", withString: "+", options: .LiteralSearch, range: nil)
        guard let url = NSURL(string: "https://www.google.com/search?q=\(formattedRequestString)") else { return }
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
    }
    
    @objc private func webViewGoBack() {
        webView.goBack()
    }
    
    @objc private func webViewGoForward() {
        webView.goForward()
    }
    
    // MARK: Activity View
    private func setupActivityViewSettings() {
        activityView.hidesWhenStopped = true
        activityView.frame = CGRect(x: view.frame.width / 2 - 10, y: view.frame.height / 2 - 10, width: 20, height: 20)
    }
    
    // MARK: - WebView Delegate
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        activityView.startAnimating()
        if webView.userInteractionEnabled == false {
            webView.userInteractionEnabled = true
        }
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityView.stopAnimating()
        goBackButton.enabled = webView.canGoBack
        goForwardButton.enabled = webView.canGoForward
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        activityView.stopAnimating()
    }
    
    // MARK: - SearchBar Delegate
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = nil 
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        webViewSearch(searchText)
        searchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
}
