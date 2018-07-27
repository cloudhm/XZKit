//
//  TestNavigationControllerViewController.swift
//  Example
//
//  Created by mlibai on 2018/1/5.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit
import XZKit

class TestNavigationControllerView: UIScrollView {
    
    let name: String
    
    init(frame: CGRect, name: String) {
        self.name = name;
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("\(name) view deinit")
    }
}

class TestNavigationControllerViewController: UIViewController, NavigationGestureDrivable, UICollectionViewDataSource {
    
    deinit {
        print("TestNavigationControllerViewController deinit")
    }
    
    static var index = 0
    
    override func loadView() {
        TestNavigationControllerViewController.index += 1
        self.view = TestNavigationControllerView.init(frame: UIScreen.main.bounds, name: "View\(TestNavigationControllerViewController.index)");
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        (self.view as! UIScrollView).contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1000)
        
        view.backgroundColor = UIColor.white
        self.navigationBar.backgroundImage  = #imageLiteral(resourceName: "bg_nav")
        
        let count = self.navigationController!.viewControllers.count
        self.navigationBar.backButton?.isHidden = (count <= 1)
        self.navigationBar.backButton?.setTitle("返回", for: .normal)
        
        self.navigationBar.title = "控制器 \(count)"
        self.navigationBar.infoButton?.setTitle("菜单", for: .normal)
        self.navigationBar.infoButton?.setTitle("高亮菜单", for: .highlighted)
        self.navigationBar.infoButton?.setTitle("已选中菜单", for: .selected)
        self.navigationBar.infoButton?.addTarget(self, action: #selector(infoButtonAction(_:)), for: .touchUpInside)
        
        
        // self.navigationBar.shadowColor = UIColor.red
        
        
        let button = UIButton.init(frame: CGRect.init(x: 100, y: 100, width: 150, height: 40));
        view.addSubview(button)
        button.setTitle("Dismiss", for: .normal);
        button.backgroundColor = UIColor.orange;
        button.addTarget(self, action: #selector(dismissButtonAction(_:)), for: .touchUpInside)
        
        let button2 = UIButton.init(frame: CGRect.init(x: 100, y: 150, width: 150, height: 40));
        view.addSubview(button2)
        button2.setTitle("Next", for: .normal);
        button2.backgroundColor = UIColor.orange;
        button2.addTarget(self, action: #selector(nextButtonAction(_:)), for: .touchUpInside)
        
        let button3 = UIButton.init(frame: CGRect.init(x: 100, y: 200, width: 150, height: 40));
        view.addSubview(button3)
        
        button3.setTitle("Status Bar", for: .normal);
        button3.backgroundColor = UIColor.orange;
        button3.addTarget(self, action: #selector(changeStatusBar(_:)), for: .touchUpInside)
        
        let button4 = UIButton.init(frame: CGRect.init(x: 100, y: 250, width: 150, height: 40));
        view.addSubview(button4)
        button4.setTitle("Navigation Bar", for: .normal);
        button4.backgroundColor = UIColor.orange;
        button4.addTarget(self, action: #selector(changeNavigationBar(_:)), for: .touchUpInside)
        
        
        let button5 = UIButton.init(frame: CGRect.init(x: 100, y: 300, width: 150, height: 40));
        view.addSubview(button5)
        button5.setTitle("Print", for: .normal);
        button5.backgroundColor = UIColor.orange;
        button5.addTarget(self, action: #selector(printButtonAction(_:)), for: .touchUpInside)
        
        let label1 = UILabel.init(frame: CGRect.init(x: 100, y: 350, width: 100, height: 40));
        label1.text = "isHidden:"
        label1.font = UIFont.systemFont(ofSize: 14.0)
        view.addSubview(label1)
        isHiddenSwitch.frame = CGRect.init(x: 200, y: 350, width: 50, height: 40)
        view.addSubview(isHiddenSwitch)
        
        let label2 = UILabel.init(frame: CGRect.init(x: 100, y: 400, width: 100, height: 40));
        label2.text = "isTranslucent:"
        label2.font = UIFont.systemFont(ofSize: 14.0)
        view.addSubview(label2)
        isTranslucentSwitch.frame = CGRect.init(x: 200, y: 400, width: 50, height: 40)
        view.addSubview(isTranslucentSwitch)
        
        let label3 = UILabel.init(frame: CGRect.init(x: 100, y: 450, width: 100, height: 40));
        label3.text = "hideTabBar:"
        label3.font = UIFont.systemFont(ofSize: 14.0)
        view.addSubview(label3)
        hideTabBarSwitch.frame = CGRect.init(x: 200, y: 450, width: 50, height: 40)
        view.addSubview(hideTabBarSwitch)
        
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize.init(width: 100, height: 100)
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 500, width: 375, height: 100), collectionViewLayout: layout)
        collectionView.alwaysBounceHorizontal = true
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        view.addSubview(collectionView)
        
        let imageViewer = ImageCarouselView.init(frame: CGRect.init(x: 0, y: 650, width: 375, height: 100))
        imageViewer.delegate = self
        imageViewer.minimumZoomScale = 0.5
        imageViewer.maximumZoomScale = 3.0
        view.addSubview(imageViewer)
    }
    
    lazy var isHiddenSwitch: UISwitch = UISwitch.init()
    lazy var isTranslucentSwitch: UISwitch = UISwitch.init()
    lazy var hideTabBarSwitch: UISwitch = UISwitch.init()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    var hideStatusBar = false;
    
    override var prefersStatusBarHidden: Bool {
        return hideStatusBar
    }
    
    @objc func infoButtonAction(_ button: UIButton) {
        button.isSelected = !button.isSelected
    }
    
    @objc func changeStatusBar(_ button: UIButton) {
        hideStatusBar = !hideStatusBar;
        setNeedsStatusBarAppearanceUpdate();
    }
    
    @objc func dismissButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func nextButtonAction(_ button: UIButton) {
        let nextVC = self.viewControllerForPushGestureInteration(self.navigationController!)!
        self.navigationController?.pushViewController(nextVC, animated: true);
    }
    
    @objc func changeNavigationBar(_ button: UIButton) {
        setNavigationBarHidden(!navigationBar.isHidden, animated: true)
    }
    
    @objc func printButtonAction(_ button: UIButton) {
        print("Status Bar: \(UIApplication.shared.statusBarFrame)");
        print("Naviga Bar: \(self.navigationController!.navigationBar.frame)")
        print("View: \(self.view.frame)")
    }
    
    func viewControllerForPushGestureInteration(_ navigationController: UINavigationController) -> UIViewController? {
        let nextVC = TestNavigationControllerViewController();
        nextVC.navigationBar.isHidden       = isHiddenSwitch.isOn;
        nextVC.navigationBar.isTranslucent  = isTranslucentSwitch.isOn;
        nextVC.hidesBottomBarWhenPushed     = hideTabBarSwitch.isOn;
        return nextVC
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.contentView.backgroundColor = UIColor.init(arc4random())
        return cell
    }
}

extension TestNavigationControllerViewController: ImageCarouselViewDelegate {
    
    func numberOfItems(in carouselView: CarouselView) -> Int {
        return 10
    }
    
    func imageCarouselView(_ imageCarouselView: ImageCarouselView, loadImageFor imageView: UIImageView, at index: Int, completion: @escaping (CGSize, Bool) -> Void) {
        imageView.image = UIImage.init(named: "img_news")
        completion(imageCarouselView.bounds.size, false)
    }
    
}
