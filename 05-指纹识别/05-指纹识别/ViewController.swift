//
//  ViewController.swift
//  05-指纹识别
//
//  Created by 蒋进 on 15/12/30.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit
import LocalAuthentication
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /**
    指纹识别本质上只是判断手机当前的主人，一旦判断成功，可以简化流程，但是实际操作不能少！
    */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        // 0. 判断设备的版本

        if (UIDevice.currentDevice().systemVersion as NSString).doubleValue < 8.0{
            
           self.inputUserInfo()
            return;
        }
        
        //初始化一个 不可变 LAContext对象
        let ctx: LAContext! = LAContext()
        
        var errora: NSError?
        
        //查看设备是否支持指纹识别，只支持iOS8以上
        if ctx.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &errora)
        {
            // 输入指纹 - 回调也是异步的
            ctx.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "swift", reply: { (success, error) -> Void in
                
                // 1. 如果输入成功，直接购买
                if (success) {
                    self.purchase()
                } else {
                    // 判断错误类型是否是自行输入密码
                    
                    if (errora!.code == LAError.UserFallback.rawValue) {
                        //异步主线程调用
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            
                            self.inputUserInfo()
                        })

                    }
                }
                
            })
            NSLog("come here");
        } else {
            NSLog("不支持指纹");
           self.inputUserInfo()
        }
            
        }


    func inputUserInfo() {
        
        alertControllerWithLogin()
        
    }

    
    func alertControllerWithLogin(){
        // 危险操作:弹框提醒
        // 1.UIAlertView
        // 2.UIActionSheet
        // iOS8开始:UIAlertController == UIAlertView + UIActionSheet
        let alert:UIAlertController = UIAlertController(title: "温馨提示", message: "请输入用户名&密码", preferredStyle: UIAlertControllerStyle.Alert)
        
        // 添加按钮
        weak var weakalert = alert
        alert.addAction(UIAlertAction(title: "sure", style: UIAlertActionStyle.Destructive, handler: { (action) -> Void in
            
            
            
            // 比较内容
            if ((weakalert?.textFields?.first?.text)! as NSString).isEqualToString("zhang") && weakalert?.textFields?.last?.text == "123"{
                
                self.purchase()
                
                NSLog("点击了确定按钮");
                
            }}))

        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
            
            NSLog("点击了取消按钮");
            
            self.inputUserInfo()
        }))
        
        // 添加文本框
        alert.addTextFieldWithConfigurationHandler { (textField) in
            
            textField.placeholder = "放弃swift"
            textField.addTarget(self, action: "usernameDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        }
        alert.addTextFieldWithConfigurationHandler { (textField) in
            
            textField.placeholder = "你真的要放弃swift吗"
            textField.secureTextEntry = true
            textField.textColor = UIColor.redColor()
            textField.addTarget(self, action: "pwdDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        }
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func usernameDidChange(username:UITextField){
        
        NSLog("%@", username.text!);
        
    }
    func pwdDidChange(username:UITextField){
        
        NSLog("%@", username.text!);
        
    }
    

    func purchase() {
        NSLog("买了!");
    }


}

