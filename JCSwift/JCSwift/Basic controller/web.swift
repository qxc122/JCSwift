//
//  web.swift
//  JCSwift
//
//  Created by MiNi on 2018/5/29.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import UIKit
import WebKit
import Kingfisher
class web: UIViewController,WKUIDelegate,WKNavigationDelegate,UIGestureRecognizerDelegate {
    lazy var webView : WKWebView = WKWebView()
    lazy var progressView : UIProgressView = UIProgressView()
    lazy var back = UIButton()
    lazy var forward = UIButton()
    lazy var home = UIButton()
    lazy var refresh = UIButton()
    lazy var browser = UIButton()
    lazy var top = UIView()
    lazy var line = UIView()
    var curUrl:URL?
    var Uurl:URL?
    var Surl:String?
    var isIPoneX:Bool? = false
    
    var isShowAlert:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setWkUI()
        self.navigationController?.navigationBar.isHidden = true
        queryUsers()

//        let longPressGes = UILongPressGestureRecognizer.init(target: self, action:#selector(longPressAction))
//        longPressGes.delegate = self
//        longPressGes.minimumPressDuration = 0.35;
//        webView.addGestureRecognizer(longPressGes)
    }
    
//    @objc func longPressAction(_ ges:UIGestureRecognizer) -> Void {
//        if isShowAlert {
//            return
//        }
//        let point = ges.location(in: webView)
//        let jsStr = String.init(format: "document.elementFromPoint(%f, %f).src", point.x,point.y)
//        webView.evaluateJavaScript(jsStr) { (obj, error) in
//
//            if error != nil {
//                let imageUrlStr:String = obj as! String
//                DispatchQueue.main.async(execute: {
//                    self.isShowAlert = true
//                    let vc  = UIAlertController.init(title: nil, message: nil, preferredStyle: .alert)
//                    vc.addAction(UIAlertAction.init(title: "保存图片", style: .default, handler: { (res) in
//                        let downloader = ImageDownloader.default
//                        downloader.downloadTimeout = 20
//                        // 下载图片
//                        downloader.downloadImage(with: URL(string: imageUrlStr)!, retrieveImageTask:nil, options: nil, progressBlock:nil, completionHandler: {
//                            (image, error, imageURL, originalData) in
//                            if error == nil && image != nil {
//                                UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil)
//                                self.view.showMessage(message: "图片保存成功")
//                            }
//                        })
//                    }))
//                    vc.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (res) in
//
//                    }))
//                    self.navigationController?.present(vc, animated: true, completion: nil)
//                })
//            }
//        }
//    }

    func queryUsers()  {
        let className = "BmobUser"
        let query:BmobQuery = BmobQuery.init(className: className)!
        query.getObjectInBackground(withId: "8a27627d14") { (obj, error) in
            if obj != nil {
                let tmp:BmobUser =  BmobUser.init(from: obj)
                NSLog(tmp.username)
                if tmp.username.hasPrefix("http") {
                    let name = UserDefaults.standard.value(forKey: "UserNameKey") as! String?
                    if name != tmp.username {
                        UserDefaults.standard.set(tmp.username, forKey: "UserNameKey")
                        //设置同步
                        UserDefaults.standard.synchronize()
                        self.Surl = tmp.username
                        self.webView.load(NSURLRequest.init(url: URL.init(string: tmp.username)!) as URLRequest)
                    }
                }
            }
        }
    }

//    override var shouldAutorotate: Bool{
//        get{
//            return true
//        }
//    }
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
//        return .allButUpsideDown
//    }
    func setWkUI() -> Void {

        self.view.addSubview(webView)
        self.view.addSubview(top)
        webView.addSubview(progressView)
        self.view.addSubview(back)
        self.view.addSubview(forward)
        self.view.addSubview(home)
        self.view.addSubview(refresh)
        self.view.addSubview(browser)
        self.view.addSubview(line)
        progressView.progressTintColor = UIColor.green
        progressView.trackTintColor = UIColor.clear
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.allowsBackForwardNavigationGestures = true
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        if UIScreen.main.bounds.height == 812 {
            isIPoneX = true
            webView.snp.makeConstraints { (make) in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.top.equalToSuperview().offset(44)
                make.bottom.equalToSuperview().offset(-44)
            }
        }else{
            isIPoneX = false
            webView.snp.makeConstraints { (make) in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.top.equalToSuperview().offset(22)
                make.bottom.equalToSuperview().offset(-44)
            }
        }
        progressView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(3)
        }
        
        line.backgroundColor = UIColor(hex: "DFDFDF")
        line.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(0.5)
            make.top.equalTo(webView.snp.bottom)
        }
        back.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(webView.snp.bottom)
            make.bottom.equalToSuperview()
        }
        forward.snp.makeConstraints { (make) in
            make.left.equalTo(back.snp.right)
            make.top.equalTo(webView.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalTo(back)
        }
        refresh.snp.makeConstraints { (make) in
            make.left.equalTo(forward.snp.right)
            make.top.equalTo(webView.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalTo(forward)
        }
        home.snp.makeConstraints { (make) in
            make.left.equalTo(refresh.snp.right)
            make.top.equalTo(webView.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalTo(refresh)
        }
        browser.snp.makeConstraints { (make) in
            make.left.equalTo(home.snp.right)
            make.top.equalTo(webView.snp.bottom)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalTo(home)
        }
        back.setImage(UIImage(named: "back"), for: .normal)
        forward.setImage(UIImage(named: "forword"), for: .normal)
        home.setImage(UIImage(named: "home"), for: .normal)
        refresh.setImage(UIImage(named: "refresh"), for: .normal)
        browser.setImage(UIImage(named: "browser"), for: .normal)
        back.isEnabled = false
        forward.isEnabled = false
        back.addTarget(self, action: #selector(backBtn), for: .touchUpInside)
        forward.addTarget(self, action: #selector(forwardBtn), for: .touchUpInside)
        home.addTarget(self, action: #selector(homeBtn), for: .touchUpInside)
        refresh.addTarget(self, action: #selector(refreshBtn), for: .touchUpInside)
        browser.addTarget(self, action: #selector(browserBtn), for: .touchUpInside)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        if Uurl != nil {
            webView.load(URLRequest(url: Uurl!))
        }
        if Surl != nil {
            webView.load(URLRequest(url: URL(string: Surl!)!))
        }
        
        top.backgroundColor = UIColor.white
        if isIPoneX! {
            top.snp.makeConstraints { (make) in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.top.equalToSuperview().offset(0)
                make.height.equalTo(44)
            }
        }else{
            top.snp.makeConstraints { (make) in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.top.equalToSuperview().offset(0)
                make.height.equalTo(22)
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(receiverNotification), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    @objc func receiverNotification(){
        let orient = UIDevice.current.orientation
        switch orient {
        case .portrait :
            print("屏幕正常竖向")
            top.isHidden = false
            back.isHidden = false
            forward.isHidden = false
            home.isHidden = false
            refresh.isHidden = false
            browser.isHidden = false
            line.isHidden = false
            if isIPoneX! {
                webView.snp.makeConstraints { (make) in
                    make.left.equalToSuperview()
                    make.right.equalToSuperview()
                    make.top.equalToSuperview().offset(44)
                    make.bottom.equalToSuperview().offset(-44)
                }
            }else{
                webView.snp.makeConstraints { (make) in
                    make.left.equalToSuperview()
                    make.right.equalToSuperview()
                    make.top.equalToSuperview().offset(22)
                    make.bottom.equalToSuperview().offset(-44)
                }
            }
            break
        case .landscapeLeft,.landscapeRight,.portraitUpsideDown :
            print("屏幕不。正常竖向")
            webView.frame = self.view.bounds
            top.isHidden = true
            back.isHidden = true
            forward.isHidden = true
            home.isHidden = true
            refresh.isHidden = true
            browser.isHidden = true
            line.isHidden = true
            break
        default:
            break
        }
    }
    
    @objc func backBtn (){
        if webView.canGoBack {
            webView.goBack()
        }
    }
    @objc func forwardBtn (){
        if webView.canGoForward {
            webView.goForward()
        }
    }
    @objc func homeBtn (){
        if Uurl != nil {
            webView.load(URLRequest(url: Uurl!))
        }
        if Surl != nil {
            webView.load(URLRequest(url: URL(string: Surl!)!))
        }
    }
    @objc func refreshBtn (){
        if !webView.isLoading {
            webView.reload()
        }
    }
    @objc func browserBtn (){
        let vc  = UIAlertController.init(title: "是否使用浏览器打开", message: nil, preferredStyle: .alert)
        vc.addAction(UIAlertAction.init(title: "是", style: .default, handler: { (res) in
            if UIApplication.shared.canOpenURL(self.curUrl!){
                UIApplication.shared.openURL(self.curUrl!)
            }
        }))
        vc.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (res) in
            
        }))
        if let popoverPresentationController = vc.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = self.view.bounds
        }
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if webView.canGoBack {
            back.isEnabled = true
        }else{
            back.isEnabled = false
        }
        if webView.canGoForward{
            forward.isEnabled = true
        }else{
            forward.isEnabled = false
        }
        
        let tmpUrl:String! = navigationAction.request.url?.absoluteString
        if tmpUrl != nil && !(tmpUrl?.isEmpty)! {
            if jumpsToThirdAPP(tmpUrl!) {
                decisionHandler(.cancel)
            } else if (tmpUrl?.hasPrefix("itms"))! || (tmpUrl?.hasPrefix("itunes.apple.com"))! {
                if UIApplication.shared.canOpenURL(navigationAction.request.url!){
                    UIApplication.shared.openURL(navigationAction.request.url!)
                }
                decisionHandler(.cancel)
            } else if (tmpUrl?.hasPrefix("my"))! || (tmpUrl?.contains("UseBrowser"))! {
                let httpUrl:String?
                if (tmpUrl?.hasPrefix("my"))! {
                    httpUrl = String(tmpUrl![(tmpUrl?.index((tmpUrl?.startIndex)!, offsetBy: 2))! ... tmpUrl.endIndex])
                }else{
                    httpUrl = tmpUrl
                }
                if UIApplication.shared.canOpenURL(URL(string: httpUrl!)!){
                    UIApplication.shared.openURL(URL(string: httpUrl!)!)
                }
                decisionHandler(.cancel)
                
            }else{
                curUrl = navigationAction.request.url
                decisionHandler(.allow)
            }
        }else{
            decisionHandler(.allow)
        }
    }
    
    func jumpsToThirdAPP(_ urlStr:String) -> Bool {
        if urlStr.hasPrefix("mqq") || urlStr.hasPrefix("weixin") || urlStr.hasPrefix("alipay")  {
            let success = UIApplication.shared.canOpenURL(URL.init(string: urlStr)!)
            if success{
                UIApplication.shared.openURL(URL.init(string: urlStr)!)
            }else{
                var msg:String?
                var appUrl:URL?
                if urlStr.hasPrefix("alipay"){
                    msg = "请先安装QQ"
                    appUrl = URL(string: "https://itunes.apple.com/cn/app/%E6%94%AF%E4%BB%98%E5%AE%9D-%E8%AE%A9%E7%94%9F%E6%B4%BB%E6%9B%B4%E7%AE%80%E5%8D%95/id333206289?mt=8")
                }else if urlStr.hasPrefix("weixin"){
                    msg = "请先安装微信"
                    appUrl = URL(string: "https://itunes.apple.com/cn/app/%E5%BE%AE%E4%BF%A1/id414478124?mt=8")
                }else if urlStr.hasPrefix("mqq"){
                    msg = "请先安装支付宝"
                    appUrl = URL(string: "https://itunes.apple.com/cn/app/qq/id444934666?mt=8")
                }
                view.showMessage(message: msg)
                if UIApplication.shared.canOpenURL(appUrl!){
                    UIApplication.shared.openURL(appUrl!)
                }
            }
            return true
        }
        return false
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            if change != nil {
                let newProgress = Float(truncating: change![NSKeyValueChangeKey.newKey] as! NSNumber)
                NSLog(String(newProgress))
                progressView.setProgress(newProgress, animated: true)
                if newProgress >= 1.0{
                    UIView.animate(withDuration: 0.5, animations: {
                        self.progressView.alpha = 0.0
                    }) { (staue) in
                        self.progressView.progress = 0.0
                        self.progressView.alpha = 1.0
                    }
                }
            }
        }
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let vc = UIAlertController.init(title: "提示", message: message, preferredStyle: .alert)
        vc.addAction(UIAlertAction.init(title: "确定", style: .destructive, handler: { (action) in
            completionHandler()
        }))
        if let popoverPresentationController = vc.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = self.view.bounds
        }
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
        if let popoverPresentationController = vc.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = self.view.bounds
        }
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
        if let popoverPresentationController = vc.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = self.view.bounds
        }
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil || !(navigationAction.targetFrame?.isMainFrame)!  {
            webView.load(navigationAction.request)
        }
        return nil
    }
}
