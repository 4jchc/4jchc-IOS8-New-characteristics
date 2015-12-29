//
//  HMShopCell.swift
//  03-WaterflowLayout瀑布流
//
//  Created by 蒋进 on 15/12/28.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HMShopCell: UICollectionViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    var shop:HMShop?{
        
        didSet{
            
            // 1.图片
            self.imageView.sd_setImageWithURL(NSURL(string: shop!.img as! String), placeholderImage: UIImage(named:"loading"))
            print("shop.img\(shop!.img)")
            // 2.价格
            self.priceLabel.text = shop!.price as? String
            
        }
        
    }


}
