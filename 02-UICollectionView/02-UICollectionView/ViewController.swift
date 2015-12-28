//
//  ViewController.swift
//  02-UICollectionView
//
//  Created by 蒋进 on 15/12/27.
//  Copyright © 2015年 sijichcai. All rights reserved.
// HMCircleLayout圆形布局 HMStackLayout中心布局 HMLineLayout水平布局

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource ,UICollectionViewDelegate{
    
    var collectionView:UICollectionView!
    
    let ID:String = "image"
    
    lazy var  images:NSMutableArray = {
        
        let ani = NSMutableArray()
        
        for var i:Int = 1; i <= 20; i++ {
            
            ani.addObject("\(i)")
        }
        return ani
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()
    
       

        changeLayout(UICollectionViewFlowLayout())

//        let w:CGFloat = self.view.frame.size.width;
//        
//        let rect:CGRect = CGRectMake(0, 100, w, 200);
//        
//        let collectionView:UICollectionView = UICollectionView.init(frame: rect, collectionViewLayout: HMStackLayout())
//
//        
//        collectionView.dataSource = self;
//        collectionView.delegate = self;
//        collectionView.registerNib(UINib(nibName: "HMImageCellForCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ID)
//        self.view.addSubview(collectionView)
//        self.collectionView = collectionView

       
        // collectionViewLayout :
        // UICollectionViewLayout
        // UICollectionViewFlowLayout
    }
    
    func changeLayout(Layout:UICollectionViewLayout){
        
        let w:CGFloat = self.view.frame.size.width + 10
        
        let rect:CGRect = CGRectMake(0, 100, w, 200);
        
        let collectionView:UICollectionView = UICollectionView.init(frame: rect, collectionViewLayout: Layout)
        
        self.view.addSubview(collectionView)
        self.collectionView = collectionView
        self.collectionView.setCollectionViewLayout(Layout, animated: true)
         //self.collectionView.contentSize = CGSizeMake(500, 500);
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.registerNib(UINib(nibName: "HMImageCellForCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ID)
    }
    

    
    
    
    
    
    
    
    
    @IBAction func changeCollectionViewLayout(sender: UIButton) {
        
    
        switch(sender.tag){
            
            case 1:
                changeLayout(HMLineLayout())
           
            case 2:
                changeLayout(HMStackLayout())
   
            case 3:
                changeLayout(UICollectionViewFlowLayout())

            case 4:
                changeLayout(HMCircleLayout())
           
        default:
            break
        }
        
        
        
    }
    
    
    
    
    
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        
//        if self.collectionView.collectionViewLayout.isKindOfClass(HMLineLayout.classForCoder()){
//            
//            self.collectionView.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: true)
//        }else {
//           // self.collectionView.setCollectionViewLayout(HMLineLayout().copy() as! UICollectionViewLayout, animated: true)
//            self.collectionView.setCollectionViewLayout(HMLineLayout(), animated: true)
//            
//        }
//        
//        
//    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if self.collectionView.collectionViewLayout.isKindOfClass(HMStackLayout.classForCoder()){
            
            self.collectionView.setCollectionViewLayout(HMCircleLayout(), animated: true)
        }else {
            // self.collectionView.setCollectionViewLayout(HMLineLayout().copy() as! UICollectionViewLayout, animated: true)
            self.collectionView.setCollectionViewLayout(HMStackLayout(), animated: true)
            
        }
        
        
    }
    
    
    
    
    
    
    //MARK:  - <UICollectionViewDataSource>

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
         return self.images.count;
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:HMImageCellForCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(ID, forIndexPath: indexPath) as! HMImageCellForCollectionViewCell
        
        cell.image = self.images[indexPath.item] as! String;
        return cell;
    }
    

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        // 删除模型数据
        self.images.removeObjectAtIndex(indexPath.item)
        
        // 删UI(刷新UI)
        collectionView.deleteItemsAtIndexPaths([indexPath])
    }



    
}

