//
//  SampleContentStatusViewController.swift
//  Example
//
//  Created by mlibai on 2018/4/3.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit
import XZKit


class SampleContentStatusView: UIView, ContentStatusRepresentable {
    
}

class SampleContentStatusViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.hidesBottomBarWhenPushed = true
    }
    
    override func loadView() {
        let view = SampleContentStatusView.init(frame: UIScreen.main.bounds)
        
        view.setTitle("Content is empty now", forContentStatus: .empty)
        view.setImage(UIImage(named: "ImageEmpty"), forContentStatus: .empty)
        
        view.setTitle("Content is loading now", forContentStatus: .loading)
        view.setImage(UIImage(named: "ImageLoading"), forContentStatus: .loading)
        
        view.contentStatus = .loading
        
        self.view = view
    }
    
    var contentView: SampleContentStatusView {
        return view as! SampleContentStatusView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.title = "ContentStatusRepresentable"
        
        self.contentView.backgroundColor = UIColor.white
        
        contentView.setImage(#imageLiteral(resourceName: "img_empty"), forContentStatus: .empty)
        contentView.setTitle("没有了...", forContentStatus: .empty)
        contentView.setTitleColor(UIColor.gray, forContentStatus: .empty)
        contentView.setTitleFont(UIFont.systemFont(ofSize: 12.0), forContentStatus: .empty)
        contentView.setTitleEdgeInsets(UIEdgeInsets.init(top: 5, left: 0, bottom: -5, right: 0), forContentStatus: .empty)
        
        let image = UIImage.animatedImageNamed("gif_searching_", duration: 1.2)
        contentView.setImage(image, forContentStatus: .loading)
        contentView.setTitle("加载中...", forContentStatus: .loading)
        contentView.setTitleColor(UIColor(0x476eadff), forContentStatus: .loading)
        contentView.setTitleFont(UIFont.systemFont(ofSize: 12.0), forContentStatus: .loading)
        contentView.setTitleEdgeInsets(UIEdgeInsets.init(top: 10, left: 0, bottom: -10, right: 0), forContentStatus: .loading)
        
        contentView.setImage(#imageLiteral(resourceName: "img_404"), forContentStatus: .error)
        contentView.setTitle("找不到...", forContentStatus: .error)
        contentView.setTitleColor(UIColor(0xc73420ff), forContentStatus: .error)
        contentView.setTitleFont(UIFont.systemFont(ofSize: 12.0), forContentStatus: .error)
        contentView.setTitleEdgeInsets(UIEdgeInsets.init(top: 5, left: 0, bottom: -5, right: 0), forContentStatus: .error)
        
        self.contentView.contentStatus = .empty
        
        self.contentView.addTarget(self, action: #selector(emptyAction(_:)), forContentStatus: .empty)
        self.contentView.addTarget(self, action: #selector(loadingAction(_:)), forContentStatus: .loading)
        self.contentView.addTarget(self, action: #selector(errorAction(_:)), forContentStatus: .error)
    }
    
    @objc private func emptyAction(_ view: UIView) {
        contentView.contentStatus = .loading
    }
    
    @objc private func loadingAction(_ view: UIView) {
        contentView.contentStatus = .error
    }
    
    @objc private func errorAction(_ view: UIView) {
        contentView.contentStatus = .empty
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
