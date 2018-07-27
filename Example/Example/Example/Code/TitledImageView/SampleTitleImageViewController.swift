//
//  SampleTitleImageViewController.swift
//  Example
//
//  Created by mlibai on 2018/4/2.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit
import XZKit

class SampleTitleImageViewController: UIViewController {
    
    @IBOutlet weak var titledImageView: TitledImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titledImageView.image = UIImage(named: "imgFreeGifts", blending: .blue)
        titledImageView.title = "用户中心"
        titledImageView.titleEdgeInsets = UIEdgeInsets.init(top: 5, left: 0, bottom: -5, right: 0)
        
        let menuBarItemView3 = TitledImageControl.init(frame: CGRect.init(x: 20, y: 100, width: 93, height: 42))
        menuBarItemView3.setTitle("Expired", for: .normal)
        menuBarItemView3.setTitleColor(UIColor(0x666666ff), for: .normal)
        menuBarItemView3.setTitleColor(UIColor(0xc0a369ff), for: .selected)
        menuBarItemView3.contentView.titleLabel.font = UIFont.systemFont(ofSize: 17.0)
        view.addSubview(menuBarItemView3)
        
        menuBarItemView3.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
    }
    
    @objc func buttonAction(_ button: TitledImageControl) {
        button.isSelected = !button.isSelected
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
