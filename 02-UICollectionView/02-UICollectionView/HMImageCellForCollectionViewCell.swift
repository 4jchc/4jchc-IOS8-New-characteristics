//
//  HMImageCellForCollectionViewCell.swift
//  02-UICollectionView
//
//  Created by 蒋进 on 15/12/27.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HMImageCellForCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!


    var image:String!{
        
        didSet{
            
            self.imageView.image = UIImage(named: image)
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageView.layer.borderWidth = 3;
        self.imageView.layer.borderColor = UIColor.whiteColor().CGColor;
        self.imageView.layer.cornerRadius = 3;
        self.imageView.clipsToBounds = true
    }

}
