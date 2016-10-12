//
//  VXSegmentedPagerController.swift
//  YingXiaoGuanJia
//
//  Created by voidxin on 16/9/5.
//  Copyright © 2016年 wugumofang. All rights reserved.
//
//
import UIKit

class VXSegmentedPagerController: UIViewController,VXSegmentViewDelegate,VXSegmentedPagerHorizControllerDelegate{
   private let headView : VXSegmentView = VXSegmentView();
 
   private let headView_H : CGFloat = 64;
   private let pageView = VXSegmentedPagerHorizController();
   private var categoryArr = NSMutableArray();
   private var controllerArr = NSMutableArray();
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        baseViewSetter();
       
        
    }
    
    func initWith(controlers : NSMutableArray){
       
        self.controllerArr.addObjectsFromArray(controlers as [AnyObject]) ;
        
        for controller in controlers {
           
             self.categoryArr.addObject(controller.title);
        }
        
        addHeadView();
        
        addPageView();
        
        
    }
    
    
   private func baseViewSetter(){
        self.view.backgroundColor = UIColor.grayColor();
    }
    
   private func addHeadView(){
        self.headView.delegate = self ;
//        self.headView.initWithDataArrayWithCollection(self.categoryArr);
    self.headView.initWithCategorys(self.categoryArr);
        self.view.addSubview(self.headView);
        self.headView .snp_makeConstraints { (make) in
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.height.equalTo(headView_H);
            make.top.equalTo(self.view);
        }
    }
    
   private func addPageView(){
        self.pageView.delegate = self;
        self.pageView.initWithControllerForDataArray(self.controllerArr, pageArr: self.categoryArr);
        let height = self.view.bounds.size.height - headView_H;
        self.pageView.view.frame = CGRectMake(0, headView_H,UIScreen.mainScreen().bounds.width, height);
        self.addChildViewController(self.pageView);
        self.view.addSubview(self.pageView.view);
        
    }
    
    //MARK: - VXSegmentView Delegate
    func itemSelectWithIndex(index: UInt) {
        self.pageView.scrollToIndexThisView(index);
    }
    
    //MARK: - VXSegmentedPagerHorizController Delegate
    func scrollViewToIndex(index: UInt) {
        self.headView.changeCollectionItemBackGroundColorWith(index);
    }
    func scrolleViewAnimationWith(offsetRatio : CGFloat,focusIndex : UInt,animationIndex : UInt) {
        self.headView.collectionItemAnimationWith(offsetRatio, focusIndex: focusIndex, animationIndex: animationIndex);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
