//
//  VXSegmentViewCollectionCell.swift
//  YingXiaoGuanJia
//
//  Created by voidxin on 16/9/5.
//  Copyright © 2016年 wugumofang. All rights reserved.
//

import UIKit
import SnapKit
class VXSegmentViewCollectionCell: UICollectionViewCell {
    
    let categoryLabel = UILabel();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
       
        contentViewSetter();
        
        addLabel();
        
    }
    func contentViewSetter(){
        self.contentView.layer.cornerRadius = 7;
        self.contentView.layer.borderColor = UIColor.grayColor().CGColor;
        self.contentView.layer.borderWidth = 0.5;
    }
    func addLabel(){
        self.categoryLabel.text = "--";
        self.categoryLabel.backgroundColor = UIColor.clearColor();
        self.categoryLabel.textColor = UIColor.blackColor();
        self.categoryLabel.font = UIFont.systemFontOfSize(15);
        self.categoryLabel.textAlignment = NSTextAlignment.Center;
        self.contentView.addSubview(self.categoryLabel);
        //
        self.categoryLabel.snp_makeConstraints { (make) in
            make.edges.equalTo(self.contentView);
        };

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
