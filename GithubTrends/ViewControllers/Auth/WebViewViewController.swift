//
//  WebViewViewController.swift
//  GithubTrends
//
//  Created by Владислав  on 12/9/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import WebKit
import OAuthSwift

final class WebViewViewController: BaseViewController, OAuthSwiftURLHandlerType {

    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var cancelItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
    }
    
    func handle(_ url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

// MARK: - WKNavigationDelegate
extension WebViewViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        switch navigationAction.navigationType {
//        case .linkActivated:
//            if navigationAction.targetFrame == nil {
//                webView.load(navigationAction.request)
//            }
//        default:
//            break
//        }
    }
    
//    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
//        switch navigationAction.navigationType {
//        case .LinkActivated:
//            if navigationAction.targetFrame == nil {
//                self.webView?.loadRequest(navigationAction.request)
//            }
//            if let url = navigationAction.request.URL where !url.absoluteString.hasPrefix("http://www.myWebSite.com/example") {
//                UIApplication.sharedApplication().openURL(url)
//                print(url.absoluteString)
//                decisionHandler(.Cancel)
//                return
//            }
//        default:
//            break
//        }
//        
//        if let url = navigationAction.request.URL {
//            print(url.absoluteString)
//        }
//        decisionHandler(.Allow)
//    }
}
