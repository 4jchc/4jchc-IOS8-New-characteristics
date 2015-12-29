//
//  ViewController.swift
//  03-WaterflowLayout瀑布流
//
//  Created by 蒋进 on 15/12/28.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, HMWaterflowLayout_OtherDelegate {

    var collectionView:UICollectionView?
    let ID:String = "shop"
   
    lazy var shops:NSMutableArray = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1.初始化数据
        let shopArray: NSArray = HMShop.mj_objectArrayWithFilename("1.plist")
        self.shops.addObjectsFromArray(shopArray as [AnyObject])
        
        let layout:HMWaterflowLayout_Other = HMWaterflowLayout_Other()
        layout.delegate = self;
        //    layout.sectionInset = UIEdgeInsetsMake(100, 20, 40, 30);
        //    layout.columnMargin = 20;
        //    layout.rowMargin = 30;
        //    layout.columnsCount = 4;
        
        // 2.创建UICollectionView
        let collectionView:UICollectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.registerNib(UINib(nibName: "HMShopCell", bundle: nil), forCellWithReuseIdentifier: ID)

        self.view.addSubview(collectionView)
        self.collectionView = collectionView;
        
        // 3.增加刷新控件
        //self.collectionView?.
        self.collectionView!.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak self]() -> Void in
            
            self!.loadMoreShops()
        })
        
    }

    
    
    func loadMoreShops(){
        
        //延时加载
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            
            let shopArray: NSArray = HMShop.mj_objectArrayWithFilename("1.plist")
  
            self.shops.addObjectsFromArray(shopArray as [AnyObject])
            self.collectionView!.reloadData()
            self.collectionView!.mj_footer.endRefreshing()
     
        })

    }
    

    //MARK:  - <HMWaterflowLayout_OtherDelegate>
    func waterflowLayout(waterflowLayout: HMWaterflowLayout_Other, heightForWidth: CGFloat, indexPath: NSIndexPath) -> CGFloat {
        

        let shop:HMShop = self.shops[indexPath.item] as! HMShop;
        print("shop.h\(shop.h)---\(shop.w)---\(shop.img)--\(shop.price)")
        return  (shop.h! as CGFloat) / (shop.w! as CGFloat) * heightForWidth
    }

    
    //MARK: - <UICollectionViewDataSource>
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.shops.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        

        let cell:HMShopCell = collectionView.dequeueReusableCellWithReuseIdentifier(ID, forIndexPath: indexPath) as! HMShopCell
        
        cell.shop = self.shops[indexPath.item] as? HMShop;
        return cell;
    }
    



}

