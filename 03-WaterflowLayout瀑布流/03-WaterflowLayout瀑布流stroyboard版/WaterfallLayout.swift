//
//  WaterfallLayout.swift
//  03-WaterflowLayout瀑布流
//
//  Created by 蒋进 on 15/12/30.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class WaterfallLayout: UICollectionViewFlowLayout {
    
    
    
    
    
    /// 列数
    var columnCount:Int!

    /// 数据数组(w, h)
    var dataList:NSArray!

    // 所有 item 的属性数组
    var layoutAttributes:NSArray!
    
    /// 准备布局，当 collectionView 的布局发生变化时，会被调用
    /// 通常是做布局的准备工作，itemSize,....
    /// 准备布局的时候，dataList 已经有值
    /// UICollectionView 的 contentSize 是根据 itemSize 动态计算出来的！
    
    
    /** 这个字典用来存储每一列最大的Y值(每一列的高度) */
    lazy var colHeight = NSMutableArray()
    
    
    // 每列中 item 的计数
    lazy var colCount = NSMutableArray()
    
    
    override func prepareLayout() {
        
    // 1. item 的宽度，根据列数，每个列的宽度是固定
        let contentWidth:CGFloat = self.collectionView!.bounds.size.width - self.sectionInset.left - self.sectionInset.right;
        let itemWidth:CGFloat = (contentWidth - CGFloat(self.columnCount - 1) * self.minimumInteritemSpacing) / CGFloat(self.columnCount)
  

    // 2. 计算布局属性
    [self attributes:itemWidth];
        
    }
    
    /// 计算布局属性
    /**
    1. 找到最高的列
    2. 知道最高列中的 item 的个数
    
    为了避免出现某一列特别短，应该每次追加列的时候，应该向最短的列追加
    */
    func attributes(itemWidth:CGFloat) {
    
    // 定义一个列高的数组，记录每一列最大的高度
        
        colHeight[self.columnCount] = CGFloat()
    
    // 每列中 item 的计数

        colCount[self.columnCount] = 03
        for var i:Int = 0; i <= self.columnCount; i++ {
            
            colHeight[i] = self.sectionInset.top;
            colCount[i] = 0;
        }
        
    
    // 定义总item高
        var totoalItemHeight:CGFloat = 0;
    
    // 遍历 dataList 数组计算相关的属性
        let arrayM:NSMutableArray = NSMutableArray(capacity: self.dataList.count)
   

        var index:Int = 0
        
        for shop in self.dataList{
            let attrs = shop as! Shop
            
            
            // 1> 建立布局属性
            let path:NSIndexPath = NSIndexPath(forItem: index, inSection: 0)
            // 创建属性
            let attr:UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: path)
            // 2> 计算当前列数
            //        NSInteger col = index % self.columnCount;
            NSInteger col = [self shortestCol:colHeight];
            
            // 将对应列数的数组计数+1
            colCount[col]++;
            
            // 3> 设置frame
            // X
            CGFloat x = self.sectionInset.left + col * (itemWidth + self.minimumInteritemSpacing);
            // Y
            CGFloat y = colHeight[col];
            // height
            CGFloat h = [self itemHeightWith:CGSizeMake(shop.w, shop.h) itemWidth:itemWidth];
            totoalItemHeight += h;
            
            attr.frame = CGRectMake(x, y, itemWidth, h);
            
            // 4> 累加列高
            colHeight[col] += h + self.minimumLineSpacing;
            
            index++;
            
            [arrayM addObject:attr];
            
        }

    
    // 设置 itemSize，使用总高度的平均值
    // 找到最高的列
    NSInteger highestCol = [self highestCol:colHeight];
    CGFloat h = (colHeight[highestCol] - colCount[highestCol] * self.minimumLineSpacing) / colCount[highestCol];
    
    // collectionView 的 contentSize 是由 itemSize 来计算获得
    self.itemSize = CGSizeMake(itemWidth, h);
    
    // 添加页脚属性
    UICollectionViewLayoutAttributes *footerAttr = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    footerAttr.frame = CGRectMake(0, colHeight[highestCol] - self.minimumLineSpacing, self.collectionView.bounds.size.width, 50);
    
    [arrayM addObject:footerAttr];
    
    // 给属性数组设置数值
    self.layoutAttributes = arrayM.copy;
    }


    
    /// 计算最短的列
    func shortestCol(colHeight:CGFloat)->Int{
        

        var min:CGFloat = CGFloat.max
        var col = 0
        for var i:Int = 0; i <= self.columnCount; i++ {
            
            if (colHeight[i]  < min) {
                min = colHeight[i];
                col = i;
            }
        }
        return col;
    }


    
    
    
    func itemHeightWith(size:CGSize,itemWidth:CGFloat)->CGFloat{
    
        return size.height * itemWidth / size.width;
    
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        // 直接返回计算完成的 属性数组
        return self.layoutAttributes;
    }
    
    
    
    
    
    

    /// 返回 collectionView 所有 item 属性的数组
    /**
    1. 跟踪效果：当到达要显示的区域时，会计算所有显示 item 的属性
    2. 一旦计算完成，所有的属性会被缓存，不会再次计算！
    
    结论：如果提前计算出所有 item 的frame，建立一个数组，在此方法中直接返回。
    应该能够达到瀑布流的效果！
    */
    //- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    //    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    //
    //    NSMutableArray *arrayM = [NSMutableArray arrayWithArray:array];
    //    NSLog(@"%@", array);
    //    [arrayM enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attr, NSUInteger idx, BOOL *stop) {
    //        attr.frame = CGRectMake(0, 0, 200, 100);
    //    }];
    //    
    //    return arrayM.copy;
    //}
    
    
    
 
}
