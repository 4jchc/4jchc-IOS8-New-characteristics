//
//  CollectionViewController.swift
//  03-WaterflowLayout瀑布流
//
//  Created by 蒋进 on 15/12/30.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var layout: WaterfallLayout!
    // 页脚视图
    var footerView:WaterfallFooterView!

    // 正在加载标记
    var loading:Bool = true
   
    
    
    // 当前的数据索引
    lazy var shops:NSMutableArray = NSMutableArray()
    var index:Int = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    /// 加载数据
    func loadData(){
        self.shops.addObjectsFromArray(Shop.shopsWithIndex(self.index) as [AnyObject])
        
        self.index++
        // 设置布局的属性
        self.layout.columnCount = 3;
        self.layout.dataList = self.shops;
        
        // 刷新数据
        self.collectionView?.reloadData()
        
    }
    
    
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: UICollectionViewDataSource
    
    //    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return
    //    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.shops.count;
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! WaterfallImageCell

        cell.shop = self.shops[indexPath.item] as! Shop
        return cell
    }
    
    
    /**
     参数
     kind：类型
     页头 UICollectionElementKindSectionHeader
     页脚 UICollectionElementKindSectionFooter
     
     Supplementary 追加视图
     */
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        // 判断是否是页脚
        if (kind == UICollectionElementKindSectionFooter) {
            self.footerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "FooterView", forIndexPath: indexPath) as! WaterfallFooterView

            return footerView;
        }
    }
    
        // 只要滚动视图滚动，就会执行
    override func scrollViewDidScroll(scrollView: UIScrollView) {

        
        if (self.footerView == nil || self.loading == true) {
            return;
        }
        
        if ((scrollView.contentOffset.y + scrollView.bounds.size.height) > self.footerView.frame.origin.y) {
            NSLog("开始刷新");
            // 如果正在刷新数据，不需要再次刷新
            self.loading = true
            
            self.footerView.indicator.startAnimating()
            
            // 模拟数据刷新
            //延时加载
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
                
                // 释放掉 footerView
                self.footerView = nil;
                
                self.loadData()
                self.loading = false
            })

        }

        }

    
    
    
    
    
    }





    // MARK: UICollectionViewDelegate
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    */
    
    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    */
    
    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return false
    }
    
    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
    return false
    }
    
    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
