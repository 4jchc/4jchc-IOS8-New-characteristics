//
//  ThreeViewController.swift
//  01-UIAlertPopoverPresentationController
//
//  Created by 蒋进 on 15/12/26.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class ThreeViewController: UIViewController {

//    - (id)initWithCoder:(NSCoder *)decoder
//    {
//    if (self = [super initWithCoder:decoder]) {
//    self.modalPresentationStyle = UIModalPresentationCustom;
//    self.transitioningDelegate = [HMTransition sharedtransition];
//    }
//    return self;
//    }
//    
//    ///从面板脱线选择
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
        self.modalPresentationStyle = UIModalPresentationStyle.Custom
        self.transitioningDelegate = HMTransition.sharedHMTransition
   
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
