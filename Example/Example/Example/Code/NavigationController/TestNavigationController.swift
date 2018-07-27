//
//  NavigationController.swift
//  XZKit
//
//  Created by mlibai on 2017/7/6.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import XZKit

class TestNavigationTabBarController: UITabBarController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    
    
}

class TestNavigationController: XZKit.NavigationController {
    
    deinit {
        print("TestNavigationController deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "XZKit"

        isNavigationBarCustomizable = true
        
        // isNavigationGestureDrivable = false
        
        
        self.view.backgroundColor = UIColor.red;
        
        // 栈底控制器如果是通过 addChildViewController 方法添加的，二级页面没有返回按钮。
        // self.setViewControllers([TestNavigationControllerViewController.init()], animated: false)
        // self.viewControllers = [TestNavigationControllerViewController.init()];
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
