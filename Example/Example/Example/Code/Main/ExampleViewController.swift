//
//  ExampleViewController.swift
//  Example
//
//  Created by mlibai on 2017/12/20.
//  Copyright © 2017年 mlibai. All rights reserved.
//

import UIKit
import XZKit

private enum Modular: String {
    case mAPIManager            = "APIManager"
    case mTheme                 = "Theme"
    case mNavigationController  = "NavigationController"
    case mCarouselView          = "CarouselView"
    case mImageCarouselView     = "ImageCarouselView"
    case mDataCryptor           = "DataCryptor"
    case mTitledImageView       = "TitledImageView"
    case mContentStatus         = "ContentStatus"
    case mImageViewPlaceholder  = "ImageViewPlaceholder"
    case mImageColorLevels      = "ImageColorLevels"
    case mCollectionViewFlowLayout = "CollectionViewFlowLayout"
    case mAlertController = "AlertController"
}

extension UIViewController: NavigationBarCustomizable {
    
    public static var navigationBarClass: NavigationBar.Type {
        return NavigationBar.self
    }
    
}


class ExampleViewController: UITableViewController {
    
    fileprivate let dataSource: [Modular] = [
        .mAPIManager, .mTheme, .mNavigationController, .mCarouselView, .mImageCarouselView, .mDataCryptor,
        .mTitledImageView, .mContentStatus, .mImageViewPlaceholder, .mImageColorLevels, .mCollectionViewFlowLayout,
        .mAlertController
    ];
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.backgroundImage = UIImage(named: "bg_nav")
        self.navigationBar.title = (isDebugMode ? "XZKit(Debug)" : "XZKit(Release)")
        self.navigationBar.titleTextColor = UIColor.white
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell");
        
        if #available(iOS 9.0, *) {
            
            self.view.semanticContentAttribute = .forceLeftToRight
        } else {
            // Fallback on earlier versions
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath);
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = dataSource[indexPath.row].rawValue;
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch dataSource[indexPath.row] {
        case .mAPIManager:
            let nextVC = APIManagerViewController.init(nibName: nil, bundle: nil);
            self.navigationController?.pushViewController(nextVC, animated: true);
        case .mTheme:
            let nextVC = SampleThemeViewController.init();
            self.navigationController?.pushViewController(nextVC, animated: true);
        case .mNavigationController:
            let nextVC = TestNavigationController.init(rootViewController: TestNavigationControllerViewController.init());
            let tabVC = TestNavigationTabBarController.init();
            tabVC.tabBar.isTranslucent = false
            tabVC.addChildViewController(nextVC)
            self.present(tabVC, animated: true, completion: nil);
        case .mCarouselView:
            let nextVC = SampleCarouselViewController.init(nibName: nil, bundle: nil)
            nextVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(nextVC, animated: true)
        case .mImageCarouselView:
            let nextVC = SampleImageCarouselViewController.init(nibName: nil, bundle: nil)
            self.navigationController?.pushViewController(nextVC, animated: true)
        case .mDataCryptor:
            let nextVC = DataCryptorSampleViewController.init()
            self.navigationController?.pushViewController(nextVC, animated: true)
            
        case .mTitledImageView:
            let nextVC = SampleTitleImageViewController.init(nibName: nil, bundle: nil)
            self.navigationController?.pushViewController(nextVC, animated: true)
            
        case .mContentStatus:
            let nextVC = SampleContentStatusViewController.init(nibName: nil, bundle: nil)
            self.navigationController?.pushViewController(nextVC, animated: true)
            
        case .mImageViewPlaceholder:
            let nextVC = SampleImageViewController.init(nibName: nil, bundle: nil)
            nextVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(nextVC, animated: true)
            
        case .mImageColorLevels:
            let nextVC = ImageColorLevelsViewController()
            nextVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(nextVC, animated: true)
            
        case .mCollectionViewFlowLayout:
            let collectionVC = FlowLayoutCollectionViewController.init()
            collectionVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(collectionVC, animated: true)
            
        case .mAlertController:
            let collectionVC = AlertController.init()
            collectionVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(collectionVC, animated: true)
            break
        }
    }
    

    override func didRecevieRedirection(_ redirection: AppRedirection) -> UIViewController? {
        XZLog("%@", redirection.currentValue)
        XZLog("%@", redirection)
        return nil
    }

}
