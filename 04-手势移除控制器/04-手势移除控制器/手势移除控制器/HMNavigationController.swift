//
//  HMNavigationController.swift
//  04-手势移除控制器
//
//  Created by 蒋进 on 15/12/29.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HMNavigationController: UINavigationController {

    
    /** 存放每一个控制器的全屏截图 */
    lazy var images:NSMutableArray = NSMutableArray()
    lazy var cover:UIView = {
        
        let ani = UIView()
        ani.backgroundColor = UIColor.blackColor()
        ani.frame = UIScreen.mainScreen().bounds
        ani.alpha = 0.5
        return ani
    }()
    lazy var lastVcView:UIImageView = {
        
        let ani = UIImageView()
        ani.frame = UIScreen.mainScreen().bounds
        return ani
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 拖拽手势
        let recognizer:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "dragging:")
        self.view.addGestureRecognizer(recognizer)
    }
    
    func dragging(recognizer:UIPanGestureRecognizer){
        // 如果只有1个子控制器,停止拖拽
        if (self.viewControllers.count <= 1) { return };
        
        
        
        // 在x方向上移动的距离
        let tx:CGFloat = recognizer.translationInView(self.view).x
         if (tx < 0) { return };
        weak var weakSelf = self
        
        if (recognizer.state == UIGestureRecognizerState.Ended || recognizer.state == UIGestureRecognizerState.Cancelled) {
            // 决定pop还是还原
            let x:CGFloat = self.view.frame.origin.x;
            if (x >= self.view.frame.size.width * 0.5) {
                UIView.animateWithDuration(0.24, animations: { () -> Void in
                    
                    self.view.transform = CGAffineTransformMakeTranslation(self.view.frame.size.width, 0);
                    
                    }, completion: { (finished) -> Void in
                        
                        weakSelf!.popViewControllerAnimated(false)
                        
                        weakSelf!.lastVcView.removeFromSuperview()
                        self.cover.removeFromSuperview()
                        self.view.transform = CGAffineTransformIdentity;
                        self.images.removeLastObject()
                })} else {
                
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    
                    self.view.transform = CGAffineTransformIdentity;
                })
                
            }} else {
            
            // 移动view
            self.view.transform = CGAffineTransformMakeTranslation(tx, 0);
            let window:UIWindow = UIApplication.sharedApplication().keyWindow!
            
            // 添加截图到最后面
            self.lastVcView.image = self.images[self.images.count - 2] as? UIImage;
            window.insertSubview(self.lastVcView, atIndex:0)
            
            window.insertSubview(self.cover ,aboveSubview:self.lastVcView)
        }
        
        
        
        
    }

    
//    func leftPan(recognizer:UIPanGestureRecognizer){
//        
//        // 在x方向上移动的距离
//        let tx:CGFloat = recognizer.translationInView(self.view).x
//        weak var weakSelf = self
//        if (recognizer.state == UIGestureRecognizerState.Ended || recognizer.state == UIGestureRecognizerState.Cancelled) {
//            // 决定pop还是还原
//            let x:CGFloat = self.view.frame.origin.x;
//            if (x >= self.view.frame.size.width * 0.5) {
//                UIView.animateWithDuration(0.24, animations: { () -> Void in
//                    
//                    self.view.transform = CGAffineTransformMakeTranslation(self.view.frame.size.width, 0);
//                    
//                    }, completion: { (finished) -> Void in
//                        
//                        weakSelf!.popViewControllerAnimated(false)
//                        
//                        weakSelf!.lastVcView.removeFromSuperview()
//                        self.cover.removeFromSuperview()
//                        self.view.transform = CGAffineTransformIdentity;
//                        self.images.removeLastObject()
//                })}else {
//                
//                UIView.animateWithDuration(0.25, animations: { () -> Void in
//                    
//                    self.view.transform = CGAffineTransformIdentity;
//                })
//                
//            }} else {
//            
//            // 移动view
//            self.view.transform = CGAffineTransformMakeTranslation(tx, 0);
//            let window:UIWindow = UIApplication.sharedApplication().keyWindow!
//            
//            // 添加截图到最后面
//            self.lastVcView.image = self.images[self.images.count - 2] as? UIImage;
//            window.insertSubview(self.lastVcView, atIndex:0)
//            
//            window.insertSubview(self.cover ,aboveSubview:self.lastVcView)
//        }
//        
//        
//        
//
//        
//        
//        
//        
//        
//    }
//    func rightPan(recognizer:UIPanGestureRecognizer){
//        
//        // 在x方向上移动的距离
//        let tx:CGFloat = recognizer.translationInView(self.view).x
//        weak var weakSelf = self
//        if (recognizer.state == UIGestureRecognizerState.Ended || recognizer.state == UIGestureRecognizerState.Cancelled) {
//            // 决定pop还是还原
//            let x:CGFloat = self.view.frame.origin.x;
//            if (x <= self.view.frame.size.width * 0.5) {
//                UIView.animateWithDuration(0.24, animations: { () -> Void in
//                    
//                    self.view.transform = CGAffineTransformMakeTranslation(self.view.frame.size.width, 0);
//                    
//                    }, completion: { (finished) -> Void in
//                        
//                        weakSelf!.popViewControllerAnimated(false)
//                        
//                        weakSelf!.lastVcView.removeFromSuperview()
//                        self.cover.removeFromSuperview()
//                        self.view.transform = CGAffineTransformIdentity;
//                        self.images.removeLastObject()
//                })}else {
//            
//            // 移动view
//            self.view.transform = CGAffineTransformMakeTranslation(tx, 0);
//            let window:UIWindow = UIApplication.sharedApplication().keyWindow!
//            
//            // 添加截图到最后面
//            self.lastVcView.image = self.images[self.images.count - 2] as? UIImage;
//            window.insertSubview(self.lastVcView, atIndex:0)
//            
//            window.insertSubview(self.cover ,aboveSubview:self.lastVcView)
//        }
//        }}
    /**
    *  产生截图
    */
    func createScreenShot(){
        
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, true, 0.0);
        self.view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext();
   
        self.images.addObject(image)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if (self.images.count > 0) {return}
        
        self.createScreenShot()
    }

    override func pushViewController(viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        
        self.createScreenShot()
    }

    
    
    
    
    
    
    
    
    }



