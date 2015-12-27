//
//  ViewController.swift
//  01-UIAlertController
//
//  Created by 蒋进 on 15/12/25.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit
///弧度
func radians(degrees:CGFloat) ->CGFloat {
    
    return ( degrees * 3.14159265 ) / 180.0;
    
}
class ViewController: UIViewController {
    
    
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //MARK: - 01-UIAlertController案例
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        

        //alertController()
        //AlertController()
        PopoverPresentationController()
        registerUserNotification()
        
       let  myTransform = CATransform3DMakeRotation(radians(45.0), 0.0, 1.0, 0.0);
        slider.layer.transform = myTransform;
        
    }

    
    func AlertController(){
        let alert:UIAlertController = UIAlertController(title: "警告", message: "你真的要放弃swift吗", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
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

    
    //MARK: - 02-UIPopoverPresentationController案例

    // UIPopoverController只能用在iPad
    func PopoverPresentationController(){
        
        let vc:SecondViewController = SecondViewController()
        //MARK:指定方向
        // modal出来是个popover
//        vc.modalPresentationStyle = UIModalPresentationStyle.Popover
//        // 取出vc所在的UIPopoverPresentationController
//        vc.popoverPresentationController!.sourceView = self.slider;
//        vc.popoverPresentationController!.sourceRect = self.slider.bounds;
        //MARK:sheet方式
        vc.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        
//        vc.popoverPresentationController!.delegate = self
//        self.preferredContentSize = CGSize(width:320,height:100)
        self.presentViewController(vc, animated: true, completion: nil)
    }

    func popover(){
        let vc:SecondViewController = SecondViewController()
        let popover:UIPopoverController = UIPopoverController(contentViewController: vc)
        popover.presentPopoverFromRect(self.slider.bounds, inView: self.slider, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)

     
    }

    // 1.只要调用了[self presentViewController:second animated:YES completion:nil];方法
    // 2.首先会创建一个UIPresentationController
    // 3.然后由UIPresentationController管理控制器的切换
    
    //MARK: - 注册通知
    func registerUserNotification(){
    
    
        if((UIDevice.currentDevice().systemVersion as NSString).floatValue >= 8.0) {
            
            UIApplication.sharedApplication().registerForRemoteNotifications()
            let types: UIUserNotificationType = [.Alert,.Sound,.Badge]
            let settings:UIUserNotificationSettings = UIUserNotificationSettings(forTypes: types, categories: nil)
            
            UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        }
 
            UIApplication.sharedApplication().applicationIconBadgeNumber = 10;
    
    
    }
    
    //MARK: - 03-自定义Modal动画
    
    func customAnimatedWithPopover(){
        
        let second:SecondViewController = SecondViewController()
        second.modalPresentationStyle = UIModalPresentationStyle.Custom
        second.transitioningDelegate = HMTransition.sharedHMTransition
        self.presentViewController(second, animated: true, completion: nil)
      
        
    }
    

    @IBAction func itemClick(sender: UIBarButtonItem) {
        
       // let three:UIViewController = UIStoryboard(name: "tree", bundle: nil).instantiateInitialViewController()!
//        let three:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("three")
//        three.modalPresentationStyle = UIModalPresentationStyle.Custom
//        three.transitioningDelegate = HMTransition.sharedHMTransition
//        self.presentViewController(three, animated: true, completion: nil)
        

    }
    


}



