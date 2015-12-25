//
//  ViewController.swift
//  01-UIAlertController
//
//  Created by 蒋进 on 15/12/25.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let alert:UIAlertController = UIAlertController(title: "警告", message: "你真的要放弃swift吗", preferredStyle: UIAlertControllerStyle.Alert)
        
        // 设置popover指向的item
        alert.popoverPresentationController?.barButtonItem = self.navigationItem.leftBarButtonItem
        
        // 添加按钮
        alert.addAction(UIAlertAction(title: "sure", style: UIAlertActionStyle.Destructive, handler: { (action) -> Void in
            
            NSLog("点击了确定按钮");
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
            
            NSLog("点击了取消按钮");
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        //alertController()
        
    }

    // UIAlertControllerStyleActionSheet的使用注意
    // 1.不能有文本框
    // 2.在iPad中,必须使用popover的形式展示
    
    // Text fields can only be added to an alert controller of style UIAlertControllerStyleAlert
    // 只能在UIAlertControllerStyleAlert样式的view上添加文本框
    // 文本框监听用addTarget
    func alertController(){
        // 危险操作:弹框提醒
        // 1.UIAlertView
        // 2.UIActionSheet
        // iOS8开始:UIAlertController == UIAlertView + UIActionSheet
        let alert:UIAlertController = UIAlertController(title: "警告", message: "你真的要放弃swift吗", preferredStyle: UIAlertControllerStyle.Alert)
        
        // 添加按钮
        weak var weakalert = alert
        alert.addAction(UIAlertAction(title: "sure", style: UIAlertActionStyle.Destructive, handler: { (action) -> Void in
            weakalert?.textFields?.first?.text
            weakalert?.textFields?.last?.text
            NSLog("点击了确定按钮");
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
            
            NSLog("点击了取消按钮");
        }))
        
        // 添加文本框
        alert.addTextFieldWithConfigurationHandler { (textField) in
            
            textField.placeholder = "放弃swift"
            
        }
        alert.addTextFieldWithConfigurationHandler { (textField) in
            
            textField.placeholder = "你真的要放弃swift吗"
            textField.secureTextEntry = true
            textField.textColor = UIColor.redColor()
            textField.addTarget(self, action: "usernameDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        }
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

    func usernameDidChange(username:UITextField){
        
        NSLog("%@", username.text!);

    }






}

