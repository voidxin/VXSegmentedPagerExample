//
//  ViewController.swift
//  VXSegmentedPagerExample
//
//  Created by 张新 on 16/9/30.
//  Copyright © 2016年 voidxin. All rights reserved.
//

import UIKit
import SnapKit
class ViewController: UIViewController {
    let button : UIButton = {
        let templeBtn = UIButton(type:UIButtonType.Custom);
        templeBtn.setTitle("podView", forState: UIControlState.Normal);
        templeBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        templeBtn.frame = CGRectMake(0, 0, 200, 44);
        templeBtn.center = CGPointMake(UIScreen.mainScreen().bounds.width / 2, UIScreen.mainScreen().bounds.height / 2)
        return templeBtn;
    }();

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.whiteColor();
        self.button.addTarget(self, action: #selector(buttonAction), forControlEvents: UIControlEvents.TouchUpInside);
        self.view.addSubview(self.button);
       
    }
    
    func buttonAction(){
        let vc1 = UIViewController();
        vc1.view.backgroundColor = UIColor.grayColor();
        vc1.title = "title1";
        let vc2 = UIViewController();
        vc2.view.backgroundColor = UIColor.greenColor();
        vc2.title = "title2";
        let vc3 = UIViewController();
        vc3.view.backgroundColor = UIColor.purpleColor();
        vc3.title = "title3";
        let vc4 = UIViewController();
        vc4.view.backgroundColor = UIColor.brownColor();
        vc4.title = "title4";
        let vc5 = UIViewController();
        vc5.view.backgroundColor = UIColor.redColor();
        vc5.title = "title5";
        
        let controllerData : NSMutableArray = [vc1,vc2,vc3,vc4,vc5];
        let pageVC = VXSegmentedPagerController();
        pageVC.initWith(controllerData);
        pageVC.title = "demo"
        self.presentViewController(pageVC, animated: true, completion: nil);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

