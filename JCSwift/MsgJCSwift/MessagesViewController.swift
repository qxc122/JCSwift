//
//  MessagesViewController.swift
//  MsgJCSwift
//
//  Created by MiNi on 2018/5/28.
//  Copyright © 2018年 wdada0620@gmail.com. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController,MSStickerBrowserViewDataSource {
    
    ///  创建数据源
    lazy var dataArray: [MSSticker] = {
        
        var array:[MSSticker] = []
        
        for i in 1...4 {
            
            if let url = Bundle.main.path(forResource: "\(i)", ofType: "png") {
                do {
                    
                    let temp = URL.init(fileURLWithPath: url)
                    
                    let sticker = try MSSticker(contentsOfFileURL: temp, localizedDescription: "")
                    array.append(sticker)
                } catch {
                    print(error)
                }
            } else if let url = Bundle.main.path(forResource: "\(i)", ofType: "gif") {
                do {
                    
                    let temp = URL.init(fileURLWithPath: url)
                    
                    let sticker = try MSSticker(contentsOfFileURL: temp, localizedDescription: "")
                    array.append(sticker)
                } catch {
                    print(error)
                }
            }else {
                
                print("如果格式不是gif也不是png请自行添加判断")
                
            }
        }
        
        return array
        
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createStickerBrowser()
        
        let tab = UITableView()
        
        tab.sectionFooterHeight = 0.1
        
    }
    
    ///  创建MSStickerBrowserViewController视图
    func createStickerBrowser() {
        
        let controller = MSStickerBrowserViewController(stickerSize: .large)
        
        addChildViewController(controller)
        
        view.addSubview(controller.view)
        
        controller.stickerBrowserView.backgroundColor = UIColor.white
        
        controller.stickerBrowserView.dataSource = self
        
        view.topAnchor.constraint(equalTo: controller.view.topAnchor).isActive = true
        
        view.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor).isActive = true
        
        view.leftAnchor.constraint(equalTo: controller.view.leftAnchor).isActive = true
        
        view.rightAnchor.constraint(equalTo: controller.view.rightAnchor).isActive = true
        
    }
    
    
    func numberOfStickers(in stickerBrowserView: MSStickerBrowserView) -> Int {
        return dataArray.count
    }
    
    func stickerBrowserView(_ stickerBrowserView: MSStickerBrowserView, stickerAt index: Int) -> MSSticker {
        return dataArray[index]
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Conversation Handling
    
    override func willBecomeActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the inactive to active state.
        // This will happen when the extension is about to present UI.
        
        // Use this method to configure the extension and restore previously stored state.
    }
    
    override func didResignActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dissmises the extension, changes to a different
        // conversation or quits Messages.
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
    }
    
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        
        // Use this method to trigger UI updates in response to the message.
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
        
        // Use this to clean up state related to the deleted message.
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called before the extension transitions to a new presentation style.
        
        // Use this method to prepare for the change in presentation style.
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
        
        // Use this method to finalize any behaviors associated with the change in presentation style.
    }
    
}
