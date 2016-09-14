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
    fileprivate let toolBar = UIToolbar()
    fileprivate var goBackButton = UIBarButtonItem()
    fileprivate var goForwardButton = UIBarButtonItem()
    fileprivate var webView = UIWebView()
    fileprivate lazy var searchBar = UISearchBar()
    fileprivate let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
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
    fileprivate func addUIElements() {
        view.addSubview(toolBar)
        view.addSubview(webView)
        webView.addSubview(activityView)
    }
    
    fileprivate func setupUIElementsPositions() {
        toolBar.frame = CGRect(x: 0, y: view.frame.height - 44, width: view.frame.width, height: 44)
        webView.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height - 108)
        activityView.frame = CGRect(x: webView.frame.width / 2 - 10, y: webView.frame.height / 2 - 10, width: 20, height: 20)
    }
    
    fileprivate func createToolBarSettings() {
        goBackButton = UIBarButtonItem(title: "<-", style: .plain, target: self, action: #selector(webViewGoBack))
        let firstFixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        firstFixedSpace.width = 20
        goForwardButton = UIBarButtonItem(title: "->", style: .plain, target: self, action: #selector(webViewGoForward))
        
        let bookMarkButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(openHistoryController))
        let flixableSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.items = [goBackButton, firstFixedSpace, goForwardButton, flixableSpace, bookMarkButton]
        
        // settings 
        enableWebBrowsingButton(false)
    }
    
    fileprivate func setupUISettings() {
        view.backgroundColor = .white
    }
    
    // MARK: Search bar
    fileprivate func createSearchBar() {
        navigationItem.titleView = searchBar
        searchBar.autocapitalizationType = .none
        searchBar.keyboardType = .webSearch
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        searchBar.placeholder = "Search or enter website address"
    }
    
    // MARK: - Settings 
    fileprivate func setupSettings() {
        definesPresentationContext = true
    }

    // MARK: - Controllers 
    fileprivate func enableWebBrowsingButton(_ bool: Bool) {
        goBackButton.isEnabled = bool
        goForwardButton.isEnabled = bool
    }

    // MARK: - WebBrowser functions 
    fileprivate func setupWebViewSettings() {
        webView.delegate = self
        webView.isUserInteractionEnabled = false
        webView.scalesPageToFit = true
    }
    
    fileprivate func webViewSearch(_ requestString: String) {
        var request: URLRequest!
        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        if predicate.evaluate(with: requestString) {
            guard let url = URL(string: requestString) else { return }
            request = URLRequest(url: url)
        } else {
            let formattedRequestString = requestString.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
            guard let url = URL(string: "https://www.google.com/search?q=\(formattedRequestString)") else { return }
            request = URLRequest(url: url)
        }
        webView.loadRequest(request)
    }
    
    @objc fileprivate func webViewGoBack() {
        webView.goBack()
    }
    
    @objc fileprivate func webViewGoForward() {
        webView.goForward()
    }
    
    // MARK: Activity View
    fileprivate func setupActivityViewSettings() {
        activityView.hidesWhenStopped = true
    }
    
    // MARK: - WebView Delegate
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        activityView.startAnimating()
        if !webView.isUserInteractionEnabled {
            webView.isUserInteractionEnabled = true
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityView.stopAnimating()
        goBackButton.isEnabled = webView.canGoBack
        goForwardButton.isEnabled = webView.canGoForward
        
        guard let pageTitle = webView.stringByEvaluatingJavaScript(from: "document.title") else { return }
        guard let URL = webView.request?.url else { return }
        print(pageTitle, URL.absoluteString)
        
        let historyEntity = HistoryURLModel()
        historyEntity.pageTitle = pageTitle
        historyEntity.urlString = URL.absoluteString
        historyEntity.date = NSDate()
    
        let dataBaseManager = DatabaseManager()
        dataBaseManager.saveURLHistory(historyEntity)
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        activityView.stopAnimating()
    }
    
    // MARK: - SearchBar Delegate
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil 
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        webViewSearch(searchText)
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    // MARK: - Navigation
    @objc fileprivate func openHistoryController() {
        let historyNaviVC = HistoryNaviViewController()
        present(historyNaviVC, animated: true, completion: nil)
    }
    
}
