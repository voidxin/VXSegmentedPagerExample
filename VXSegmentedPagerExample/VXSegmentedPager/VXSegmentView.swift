//
//  VXSegmentView.swift
//  VXSegmentedPagerExample
//
//  Created by 张新 on 16/10/1.
//  Copyright © 2016年 voidxin. All rights reserved.
//

import UIKit
protocol VXSegmentViewDelegate  : NSObjectProtocol{
    func itemSelectWithIndex(index : UInt);
}
class VXSegmentView: UIView,UIScrollViewDelegate {
    weak var delegate: VXSegmentViewDelegate?
    let scrolllView : UIScrollView = UIScrollView();
    private let KItem_Htight : CGFloat = 35;
    private let KBorder_Width : CGFloat = 15;
    private let KItem_Width : CGFloat = 100;
    var currentIndex : Int = 0;
    var itemBackGroundColor : UIColor = {
        return UIColor.whiteColor();
    }();
    var itemTitleColor : UIColor = {
        return UIColor.grayColor();
    }();
    var segmentViewColor : UIColor = {
        var templeColor =  UIColor.init(red:223,green:221,blue:223,alpha: 1);
        return templeColor;
    }();
    var itemArray : NSMutableArray = {
        var templeItemArray = NSMutableArray();
        return templeItemArray;
    }();
    
    
    //---- ----
    var colorValue : CGFloat = 0x90 / 0xFF;
    var offsetRatio : CGFloat = 0;
    var F_index : Int = 0;
    var a_index : Int = 0;
    
   
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
      
        
    }
    
    func initWithCategorys(categorys : NSMutableArray){
        addScrollerView();
        for i in 0...categorys.count-1 {
            let title : NSString = categorys[i] as! NSString;
            let button = UIButton(type:UIButtonType.Custom);
            button.setTitle(title as String, forState: UIControlState.Normal);
            button.setTitleColor(itemTitleColor, forState: UIControlState.Normal);
            button.backgroundColor = self.itemBackGroundColor;
            button.layer.cornerRadius = 8;
            button.layer.borderColor = UIColor.grayColor().CGColor;
            button.layer.borderWidth = 1;
            button.tag = 10010 + i;
            button.addTarget(self, action: #selector(itemClicked), forControlEvents: UIControlEvents.TouchUpInside);
            self.scrolllView.addSubview(button);
            self.itemArray.addObject(button);
            button.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(KBorder_Width + CGFloat(i) * KItem_Width + KBorder_Width * CGFloat(i));
                make.height.equalTo(KItem_Htight);
                make.width.equalTo(KItem_Width);
                make.centerY.equalTo(self.scrolllView);
            })
        }
        self.scrolllView.contentSize = CGSizeMake(KBorder_Width * CGFloat(categorys.count) + KItem_Width * CGFloat(categorys.count) + KBorder_Width , self.bounds.height);
         //
       
        
    }
    
    private func addScrollerView(){
        self.scrolllView.backgroundColor = segmentViewColor;
        self.scrolllView.delegate = self;
        self.addSubview(self.scrolllView);
        self.scrolllView.snp_makeConstraints { (make) in
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 设置collectionItem的背景颜色(左右滑动的时候根据页面所对应的下标去改变item的颜色)
    func changeCollectionItemBackGroundColorWith(index : UInt){
        for i in 0...self.itemArray.count-1 {
            let button : UIButton = self.itemArray[i] as! UIButton;
            if button.tag != Int(index + 10010) {
                button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal);
                 button.transform = CGAffineTransformIdentity;
            }else{
                button.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal);
                button.transform = CGAffineTransformMakeScale(1.2, 1.2);
            }
        }
        
        self.scrolllView.contentOffset = CGPointMake(KItem_Width * CGFloat(index), 0);
        
        

    }
    
    //MARK: 滑动页面时collectionView 的动画效果
    //这里会崩溃
    func collectionItemAnimationWith(offsetRatio : CGFloat,focusIndex : UInt,animationIndex : UInt){
        self.offsetRatio  = CGFloat(offsetRatio);
        self.F_index  = Int(animationIndex);
        self.a_index  = Int(focusIndex);
        print(String(format:"F_index : %ld", self.F_index));
        print(String(format:"a_index : %ld", self.a_index));
        let titleFrom : UIButton = self.itemArray[self.F_index] as! UIButton;
        let titleTo : UIButton = self.itemArray[self.a_index] as! UIButton;
       UIView.transitionWithView(titleFrom, duration: 0.1, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
        titleFrom.setTitleColor(UIColor.init(red: self.colorValue*(1-self.offsetRatio), green: self.colorValue, blue: self.colorValue*(1-offsetRatio), alpha: 1), forState: UIControlState.Normal);
        
            titleFrom.transform = CGAffineTransformMakeScale(1 + 0.2 *  self.offsetRatio, 1 + 0.2 *  self.offsetRatio);
        
        }, completion: nil);
        
        UIView.transitionWithView(titleTo, duration: 0.1, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
            titleFrom.setTitleColor(UIColor.init(red: self.colorValue*offsetRatio , green: self.colorValue, blue: self.colorValue*offsetRatio, alpha: 1), forState: UIControlState.Normal);
            
            titleTo.transform = CGAffineTransformMakeScale(1 + 0.2 * (1-offsetRatio), 1 + 0.2 * (1-offsetRatio));
            
            }, completion: nil);
    };
    
    func itemClicked(button : UIButton){
        
        if (self.currentIndex != button.tag) {
            let index : Int = self.currentIndex;
           let selectedItem : UIButton = self.itemArray[index] as! UIButton;
            selectedItem.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal);
            selectedItem.transform = CGAffineTransformIdentity;
            button.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal);
            button.transform = CGAffineTransformMakeScale(1.2, 1.2);
            //-----
            if self.currentIndex > button.tag-10010 {
                self.scrolllView.contentOffset = CGPointMake(KItem_Width * CGFloat(button.tag-10010), 0);
            }
            if button.frame.maxX > UIScreen.mainScreen().bounds.width {
                 self.scrolllView.contentOffset = CGPointMake(KItem_Width * CGFloat(button.tag-10010), 0);
               
            }

            
            
            self.currentIndex = button.tag-10010;
           
        }
        
        
        if self.delegate != nil {
            self.delegate!.itemSelectWithIndex(UInt(button.tag-10010));
        }
        
       

        print("this tag is :" + String(button.tag));
        
    }
    
    
    //MARK: - scrollView滚动
    func scrollViewFunction(){
//        
//        let visibleBounds : CGRect = self.scrolllView.bounds;
//        
//        
//        
//        let minx = CGRectGetMinX(visibleBounds);
//        let minxFloorf = floor(Double(minx));
//        let visibleWidth = CGRectGetWidth(visibleBounds);
//        let maxX = CGRectGetMaxX(visibleBounds)-1
//        let maxXFloor = floor(maxX);
//        
//        let firstNeededPageIndex : Int = Int(minxFloorf) / Int(visibleWidth);
//        
//        let lastNeededPageIndex  = maxXFloor / visibleWidth;
//        
//      
//        
//        --firstNeededPageIndex;
//        
//        ++lastNeededPageIndex;
//        
//        firstNeededPageIndex = MAX(firstNeededPageIndex, 0);
//        
//        lastNeededPageIndex  = MIN(lastNeededPageIndex, 7);
//        
//        NSLog(@"firsr:%d, last:%d", firstNeededPageIndex, lastNeededPageIndex);
    }


}
