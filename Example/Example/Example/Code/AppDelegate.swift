//
//  AppDelegate.swift
//  XZKit
//
//  Created by mlibai on 06/13/2017.
//  Copyright (c) 2017 mlibai. All rights reserved.
//

import UIKit
import XZKit
import StoreKit
import AVFoundation
import AFNetworking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let tabBarVC = ExampleTabBarController.init();
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = tabBarVC
        window.makeKeyAndVisible()
        self.window = window;
        
        let redirection = AppRedirection.init(["页面重定向1", "页面重定向2", "页面重定向3", "页面重定向4"])
        tabBarVC.setNeedsRedirect(with: redirection)
        
        XZLog("DispatchQueue: 1")
        DispatchQueue.XZKit.concurrent.async({
            XZLog("DispatchQueue: 2")
            DispatchQueue.XZKit.concurrent.sync({ (_) in
                XZLog("DispatchQueue: 3")
            }, flags: .barrier)
            XZLog("DispatchQueue: 4")
        })
        XZLog("DispatchQueue: 5")
        
        let d = UIDevice.current
        XZLog("%@ %@ %@", UIDevice.current.model, Device.current, d)
        
        XZLog("\"\u{2067}السلع: \u{2066}$130\u{2069}\u{2069}\"")
        
        XZLog("%@", AppLanguage.current)
        
        AppLanguage.current = "en"
        
        return true
        
    }
    


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


