//
//  VXSegmentedPagerHorizController.swift
//  YingXiaoGuanJia
//
//  Created by voidxin on 16/9/6.
//  Copyright © 2016年 wugumofang. All rights reserved.
//
// scroller tableView
import UIKit
import SnapKit
protocol VXSegmentedPagerHorizControllerDelegate : NSObjectProtocol {
    func scrollViewToIndex(index : UInt);
    func scrolleViewAnimationWith(offsetRatio : CGFloat,focusIndex : UInt,animationIndex : UInt);
}
class VXSegmentedPagerHorizController: UITableViewController {
    var controllerArray :NSArray = NSArray();
    var pageArray : NSArray = NSArray();
    var currentIndex : UInt = 0;
    weak var delegate : VXSegmentedPagerHorizControllerDelegate?;
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor();
    }
    
    func initWithControllerForDataArray(controllerArr : NSArray,pageArr : NSArray){
        self.controllerArray = controllerArr;
        self.pageArray = pageArr;
         tableViewSetter();
    }
    
    // MARK: - taleViewSetter
    func tableViewSetter(){
        let pi2 : CGFloat = CGFloat(-M_PI_2);
        self.tableView = UITableView();
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
        self.tableView.scrollsToTop = false;
        self.tableView.transform = CGAffineTransformMakeRotation(pi2);
        self.tableView.showsVerticalScrollIndicator = false;
        self.tableView.pagingEnabled = true;
        self.tableView.backgroundColor = UIColor.whiteColor();
        self.tableView.bounces = false;
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CELL");

    }
    
    //MARK: - 指定滚动到第几行
    
    func scrollToIndexThisView(index : UInt){
        let indexC : Int = Int(index);
        self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow:indexC, inSection: 0), atScrollPosition: UITableViewScrollPosition.None, animated: true);
        self.currentIndex = index;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       
        return 1;
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return self.pageArray.count;
       
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CELL", forIndexPath: indexPath)
        let pi2 : CGFloat = CGFloat(M_PI_2);
        cell.contentView.transform = CGAffineTransformMakeRotation(pi2);
        let controller : UIViewController = self.controllerArray[indexPath.row] as! UIViewController;
        controller.view.frame = cell.contentView.bounds;
        cell.contentView.addSubview(controller.view);
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UIScreen.mainScreen().bounds.width;
    }
    
    //MARK: - scrollView delegate
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        scrollStop(true);
    }
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollStop(false);
    }
    
    
    
    func scrollStop(didScrollStop : Bool){
    
        let horizonalOffset : CGFloat = self.tableView.contentOffset.y;
        let screenWidth : CGFloat = self.tableView.frame.size.width;
        var offsetRatio : CGFloat = CGFloat(UInt(horizonalOffset) % UInt(screenWidth)) / screenWidth;
        let focusIndex : UInt = UInt((horizonalOffset + screenWidth / 2) / screenWidth);
        if (horizonalOffset != CGFloat(focusIndex) * screenWidth) {
            let animationIndex : UInt = horizonalOffset > CGFloat(focusIndex) * screenWidth ? focusIndex + 1: focusIndex - 1;
            if (focusIndex > animationIndex) {
                offsetRatio = 1 - offsetRatio;
                if self.delegate != nil {
                    self.delegate?.scrolleViewAnimationWith(offsetRatio, focusIndex: focusIndex, animationIndex: animationIndex);
                }
            }
        }
        
        if didScrollStop {
            self.currentIndex = focusIndex;
            self.delegate?.scrollViewToIndex(focusIndex);
        }

        
    }
    

  
}
