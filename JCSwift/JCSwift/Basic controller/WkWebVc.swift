//
//  WkWebVc.swift
//  JCSwift
//
//  Created by MiNi on 2018/5/22.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import UIKit
import WebKit
class WkWebVc: BasicVc,WKUIDelegate,WKNavigationDelegate {
    
    lazy var webView : WKWebView = WKWebView()
    lazy var progressView : UIProgressView = UIProgressView()
    
    var config : WKWebViewConfiguration?
    var Uurl:URL?
    var Surl:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setWkUI()
    }
    func setWkUI() -> Void {
        if config != nil {
            webView = WKWebView.init(frame: view.frame, configuration: config!)
        }
        self.view.addSubview(webView)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        self.view.addSubview(progressView)
        progressView.progressTintColor = UIColor.blue
        progressView.trackTintColor = UIColor.clear
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.allowsBackForwardNavigationGestures = true
        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        webView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        progressView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(2)
        }
        if Uurl != nil {
            webView.load(URLRequest(url: Uurl!))
        }
        if Surl != nil {
            webView.load(URLRequest(url: URL(string: Surl!)!))
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "title" {
            if (webView.title != nil) && !(webView.title?.isEmpty)! {
                self.title = webView.title
            }
        } else if keyPath == "estimatedProgress" {
            if change != nil {
                let newProgress = Float(truncating: change![NSKeyValueChangeKey.newKey] as! NSNumber)
                NSLog(String(newProgress))
                progressView.progress = newProgress
                if newProgress >= 1.0{
                    progressView.progress = 0.0
                }
            }
        }
    }

    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let vc = UIAlertController.init(title: "提示", message: message, preferredStyle: .alert)
        vc.addAction(UIAlertAction.init(title: "确定", style: .destructive, handler: { (action) in
            completionHandler()
        }))
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let vc = UIAlertController.init(title: "请确认", message: message, preferredStyle: .alert)
        vc.addAction(UIAlertAction.init(title: "确定", style: .destructive, handler: { (action) in
            completionHandler(true)
        }))
        vc.addAction(UIAlertAction.init(title: "取消", style:  .cancel, handler: { (action) in
            completionHandler(false)
        }))
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let vc = UIAlertController.init(title: "提示", message: nil, preferredStyle: .alert)
        vc.addAction(UIAlertAction.init(title: "确定", style: .destructive, handler: { (action) in
             let input =  vc.textFields?.first
            if input != nil{
                completionHandler(input?.text)
            }
        }))
        vc.addAction(UIAlertAction.init(title: "取消", style:  .cancel, handler: { (action) in
            completionHandler(nil)
        }))
        vc.addTextField { (input) in
            input.placeholder = prompt
        }
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if !(navigationAction.targetFrame?.isMainFrame)!  {
            webView.load(navigationAction.request)
        }
        return nil
    }
}
