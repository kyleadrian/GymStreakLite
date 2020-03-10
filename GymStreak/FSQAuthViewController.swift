//
//  FSQAuthViewController.swift
//  GymTracker
//
//  Created by Kyle Wiltshire on 3/6/20.
//  Copyright © 2020 Kyle Wiltshire. All rights reserved.
//

import UIKit
import WebKit

protocol FSQAuthViewControllerDelegate {
    func FSQAuthViewControllerDidSucceed(accessToken: String)
    func FSQAuthViewControllerDidFail(error: Error)
}

class FSQAuthViewController: UIViewController {
    private let authUrl = "https://foursquare.com/oauth2/authenticate?client_id=%@&response_type=token&redirect_uri=%@"

    var webview: WKWebView!
    var clientId: String
    var callback: String
    var delegate: FSQAuthViewControllerDelegate?

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(clientId: String, callback: String) {
        self.clientId = clientId
        self.callback = callback
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(FSQAuthViewController.cancel(_:)))

        let rect : CGRect = UIScreen.main.bounds
        self.webview = WKWebView(frame: CGRect(x: 0, y: 64, width: rect.size.width, height: rect.size.height - 64))
        self.webview.navigationDelegate = self
        self.view.addSubview(self.webview!)

        let authURLString = String(format: authUrl, self.clientId, self.callback)
        guard let encodedURLString = authURLString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            print("Invalid URL: ", authURLString)
            return
        }

        guard let authURL = URL(string: encodedURLString) else {
            print("Invalid URL: ", authURLString)
            return
        }
        _ = self.webview?.load(URLRequest(url: authURL))
    }

// MARK: - Private methods
    @objc func cancel(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - WKWebView delegate
extension FSQAuthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let urlString = navigationAction.request.url?.absoluteString,
            urlString.range(of: "access_token=") != nil {
            if let accessToken = urlString.components(separatedBy: "=").last {
                delegate?.FSQAuthViewControllerDidSucceed(accessToken: accessToken)
                dismiss(animated: true, completion: nil)
                decisionHandler(WKNavigationActionPolicy.cancel)
                return
            }
        }

        decisionHandler(WKNavigationActionPolicy.allow)
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        delegate?.FSQAuthViewControllerDidFail(error: error)
    }
}
