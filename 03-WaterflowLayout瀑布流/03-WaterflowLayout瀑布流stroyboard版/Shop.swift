//
//  Shop.swift
//  03-WaterflowLayout瀑布流
//
//  Created by 蒋进 on 15/12/30.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class Shop: NSObject {
    
    
    var w:CGFloat?
    var h:CGFloat?
    var img:NSString?
    var price:NSString?

    static func shopWithDict(dict:NSDictionary) ->Shop{
        
        let obj:Shop = Shop()
        obj.setValuesForKeysWithDictionary(dict as! [String : AnyObject])
        return obj
        
    }
    
    static func shopsWithIndex(index:NSInteger)->NSArray{
        
        let  array = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("\((index % 3) + 1).plist", ofType: nil)!)!
        
        let arrayM:NSMutableArray = NSMutableArray(capacity: array.count)
        array.enumerateObjectsUsingBlock { (obj, idx, stop) -> Void in
            
            arrayM.addObject(self.shopWithDict(obj as! NSDictionary))
      
        }
        return arrayM.copy() as! NSArray
        
        // 提示：之所以返回 copy，建立一个不可变的数组，外界无法修改
        // 否则，外面可以通过 id 其他的方法修改数组内容，不够安全！
        
}


}




