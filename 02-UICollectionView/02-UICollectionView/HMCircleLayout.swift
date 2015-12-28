//
//  HMCircleLayout.swift
//  02-UICollectionView
//
//  Created by 蒋进 on 15/12/28.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HMCircleLayout: UICollectionViewLayout {
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        
        return true
    }
    
    override func collectionViewContentSize() -> CGSize {
        
        return CGSizeMake(500, 500);
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        

        // 1.取得默认的cell的UICollectionViewLayoutAttributes
        let attrs:UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        attrs.size = CGSizeMake(50, 50);
        // 圆的半径
        let circleRadius:CGFloat = 70
        let circleCenter:CGPoint = CGPointMake(self.collectionView!.frame.size.width * 0.5, self.collectionView!.frame.size.height * 0.5);
        // 每个item之间的角度
        let angleDelta:CGFloat = CGFloat(M_PI * 2) / CGFloat((self.collectionView?.numberOfItemsInSection(indexPath.section))!)
        
        
        attrs.center = CGPointMake(self.collectionView!.frame.size.width * 0.5, self.collectionView!.frame.size.height * 0.5);
        
        // 计算当前item的角度
        let angle:CGFloat = CGFloat(indexPath.item) * angleDelta;
        
        
        attrs.center = CGPointMake(circleCenter.x + circleRadius * CGFloat(cosf(Float(angle))), circleCenter.y - circleRadius * CGFloat(sinf(Float(angle))))
        
        attrs.zIndex = indexPath.item;
        
        return attrs;

    }
    
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let array:NSMutableArray = NSMutableArray()
        let count:Int = (self.collectionView?.numberOfItemsInSection(0))!
        for var i:Int = 0; i < count; i++ {
            
            let attrs:UICollectionViewLayoutAttributes = self.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: i, inSection: 0))!
            
            array.addObject(attrs)
        }
        
        return array as NSArray as? [UICollectionViewLayoutAttributes]
    }
    
    

}
