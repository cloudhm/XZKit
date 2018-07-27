//
//  ExampleTabBarController.swift
//  Example
//
//  Created by mlibai on 2018/6/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit

class ExampleTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        tabBar.tintColor     = UIColor(0xea7653ff)

        let mainVC = ExampleViewController.init(style: .plain);
        let mainNavigationVC = ExampleNavigationController.init(rootViewController: mainVC);
        mainNavigationVC.tabBarItem.image           = #imageLiteral(resourceName: "icon_tab_home")
        mainNavigationVC.tabBarItem.selectedImage   = #imageLiteral(resourceName: "icon_tab_home_selected")
        mainNavigationVC.tabBarItem.title           = "XZKit"
        addChildViewController(mainNavigationVC);
        
        let userVC = UIViewController.init()
        let userNavigationVC = ExampleNavigationController.init(rootViewController: userVC)
        userNavigationVC.tabBarItem.image           = #imageLiteral(resourceName: "icon_tab_user")
        userNavigationVC.tabBarItem.selectedImage   = #imageLiteral(resourceName: "icon_tab_user_selected")
        userNavigationVC.tabBarItem.title           = "Settings"
        addChildViewController(userNavigationVC)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
