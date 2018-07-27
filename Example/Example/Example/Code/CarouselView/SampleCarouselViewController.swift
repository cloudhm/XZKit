//
//  SampleCarouselViewController.swift
//  Example
//
//  Created by mlibai on 2018/3/28.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit
import XZKit

class SampleCarouselViewController: UIViewController, CarouselViewDelegate {
    
    
    @IBOutlet weak var carouselView: CarouselView!
    
    
    let images: [UIImage] = [
        UIImage(named: "20170704142100")!,
        UIImage(named: "20170704142104")!,
        UIImage(named: "20170704142107")!,
        UIImage(named: "20170704142108")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hidesBottomBarWhenPushed = true;
        
        automaticallyAdjustsScrollViewInsets = false;
        view.backgroundColor = UIColor.white
        
        carouselView.isWrapped     = true;
        carouselView.timeInterval  = 0;
        carouselView.delegate      = self;
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func isWrappedDidChange(_ sender: UISwitch) {
        carouselView.isWrapped = sender.isOn
    }
    
    @IBAction func timeIntervalDidChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            carouselView.timeInterval -= 1;
            
        case 2:
            carouselView.timeInterval += 1;
            
        default: return
        }
        
        sender.setTitle(String.init(carouselView.timeInterval), forSegmentAt: 1)
        sender.selectedSegmentIndex = UISegmentedControlNoSegment
    }
    
    var numberOfViews: Int = 0
    
    @IBAction func numberOfViewsDidChange(_ sender: UISegmentedControl) {
        numberOfViews = sender.selectedSegmentIndex
    }
    
    @IBAction func confirmButtonAction(_ sender: UIButton) {
        carouselView.reloadViews()
    }
    
    func numberOfItems(in carouselView: CarouselView) -> Int {
        return numberOfViews
    }
    
    func carouselView(_ carouselView: CarouselView, viewForItemAt index: Int, reusing reusingView: UIView?) -> UIView? {
        if let imageView = reusingView as? UIImageView {
            imageView.image = images[index];
            imageView.sizeToFit()
            return imageView;
        } else {
            let imageView = UIImageView.init(image: images[index])
            imageView.sizeToFit()
            return imageView;
        }
        // 测试双击放大后，内容视图依然小于容器视图时的表现。
        // view.frame = CGRect.init(x: 0, y: 0, width: 10, height: 10)
        // 显示图片实际大小。
    }
    
    func carouselView(_ carouselView: CarouselView, didShowViewAt index: Int) {
        XZLog("Did Show View at \(index)")
    }
    
    
}
