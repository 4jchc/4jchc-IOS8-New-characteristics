//
//  HMStackLayout布局.swift
//  02-UICollectionView
//
//  Created by 蒋进 on 15/12/28.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HMStackLayout: UICollectionViewLayout {

    let HMRandom0_1:CGFloat = CGFloat(arc4random_uniform(UInt32(100)))/100.0

    override func collectionViewContentSize() -> CGSize {
        
        return CGSizeMake(500, 500);
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        
        return true
    }
    
//    override func collectionViewContentSize() -> CGSize {
//        
//        return CGSizeMake(500, 500);
//    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let angles:NSArray = [0, (-0.2), (-0.5), (0.2), (0.5)];
        
        // 1.取得默认的cell的UICollectionViewLayoutAttributes
        let attrs:UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        attrs.size = CGSizeMake(100, 100);
        attrs.center = CGPointMake(self.collectionView!.frame.size.width * 0.5, self.collectionView!.frame.size.height * 0.5);
        
        if (indexPath.item >= 5) {
            attrs.hidden = true
        } else {
            
            attrs.transform = CGAffineTransformMakeRotation(angles[indexPath.item] as! CGFloat)
            // zIndex越大,就越在上面
            attrs.zIndex = (self.collectionView?.numberOfItemsInSection(indexPath.section))! - indexPath.item;
        }
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
    



