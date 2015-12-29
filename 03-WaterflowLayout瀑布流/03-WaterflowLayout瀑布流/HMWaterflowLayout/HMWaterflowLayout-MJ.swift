//
//  HMWaterflowLayout.swift
//  03-WaterflowLayout瀑布流
//
//  Created by 蒋进 on 15/12/28.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

///*****✅1.1定义代理协议
protocol HMWaterflowLayoutDelegate:NSObjectProtocol{
    
    func waterflowLayout(waterflowLayout:HMWaterflowLayout, heightForWidth :CGFloat,indexPath:NSIndexPath)->CGFloat
  
}


class HMWaterflowLayout: UICollectionViewLayout {
    

    var sectionInset:UIEdgeInsets = UIEdgeInsets()
    /** 每一列之间的间距 */
    var columnMargin:CGFloat = CGFloat()
    /** 每一行之间的间距 */
    var rowMargin:CGFloat = CGFloat()
    /** 显示多少列 */
    var columnsCount:Int?

    ///*****✅1.2初始化代理协议
    weak var delegate:HMWaterflowLayoutDelegate!
    
    /** 这个字典用来存储每一列最大的Y值(每一列的高度) */
    lazy var maxYDict:NSMutableDictionary = NSMutableDictionary()

    /** 存放所有的布局属性 */
    lazy var attrsArray:NSMutableArray = NSMutableArray()

    override init() {
        
        self.columnMargin = 10;
        self.rowMargin = 10;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.columnsCount = 3;
        super.init()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        
        return true
    }

    
    /**
    *  每次布局之前的准备
    */
    override func prepareLayout() {
        super.prepareLayout()
        // 1.清空最大的Y值
        for var i:Int = 0; i < self.columnsCount; i++ {
            
            let column:String = "i"
            self.maxYDict[column] = (self.sectionInset.top);
        }
        
        // 2.计算所有cell的属性
        self.attrsArray.removeAllObjects()
      
        let count:Int = (self.collectionView?.numberOfItemsInSection(0))!
        for var i:Int = 0; i < count; i++ {
           
            let attrs:UICollectionViewLayoutAttributes = self.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: i, inSection: 0))!
     
            self.attrsArray.addObject(attrs)
            
        }
    
    }

    
    /**
    *  返回所有的尺寸
    */
    override func collectionViewContentSize() -> CGSize {

        var maxColumn:NSString = "0"

        self.maxYDict.enumerateKeysAndObjectsUsingBlock( { (column: AnyObject!, maxY: AnyObject!, stop: UnsafeMutablePointer<ObjCBool>) -> () in
            
            if (maxY as! NSNumber).floatValue > self.maxYDict[maxColumn]?.floatValue {
                
                maxColumn = column as! NSString
            }
        })
        return CGSizeMake(0, self.maxYDict[maxColumn]! as! CGFloat + self.sectionInset.bottom as CGFloat);
    
    }


    /**
    *  返回indexPath这个位置Item的布局属性
    */
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
//        // 假设最短的那一列的第0列
//        var minColumn:NSString = "0"
//        // 找出最短的那一列
//        self.maxYDict.enumerateKeysAndObjectsUsingBlock( { (column: AnyObject!, maxY: AnyObject!, stop: UnsafeMutablePointer<ObjCBool>) -> () in
//            
//            
//            if maxY.floatValue < self.maxYDict[minColumn]?.floatValue {
//                
//                minColumn = column as! NSString
//                print(minColumn)
//            }
//            
//        })
        // 获取最短那一列
        var minColumn:Int = 0  // 先假设第0列最短
        for (column, maxY) in maxYDict {
            // 当前这列的最大Y值 小于 第 minYColumn 列的最大Y值
            if maxY.floatValue < maxYDict[minColumn]?.floatValue {
                // 找到更短的一列
                print("maxYDict[minColumn]?.floatValue\(maxYDict[minColumn]?.floatValue)")
                minColumn = column as! Int
            }
        }
        
        
        
        
        
        
        // 计算尺寸
        let width:CGFloat = (self.collectionView!.frame.size.width - self.sectionInset.left - self.sectionInset.right - CGFloat(self.columnsCount! - 1) * self.columnMargin)/CGFloat(self.columnsCount!)
        
        let height:CGFloat = self.delegate.waterflowLayout(self, heightForWidth: width, indexPath: indexPath)

        // 计算位置
        let x:CGFloat = self.sectionInset.left + (width + self.columnMargin) * CGFloat(minColumn)
        print((self.maxYDict), "----\(x)----\(width)")
        var y:CGFloat = 0

        if let max = self.maxYDict[minColumn] as? CGFloat{
            
            y = (max) + self.rowMargin
        }

        // 更新这一列的最大Y值
        self.maxYDict[minColumn] = (y + height);
        
        // 创建属性
        let attrs:UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        
        attrs.frame = CGRectMake(x, y, width, height);
        print("attrsattrs\(attrs)")
        return attrs;
        
    }


    /**
    *  返回rect范围内的布局属性
    */
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        return self.attrsArray as NSArray as? [UICollectionViewLayoutAttributes]
    }


    
    
    
    
    
}
