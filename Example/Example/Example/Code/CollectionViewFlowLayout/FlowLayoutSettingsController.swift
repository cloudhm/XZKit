//
//  FlowLayoutSettingsController.swift
//  Example
//
//  Created by mlibai on 2018/7/18.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit
import XZKit

private let reuseIdentifier = "Cell"

class FlowLayoutSettingsController: UITableViewController {
    
    static func show(for collectionViewLayout: CollectionViewFlowLayout, from view: UIView, delegate: UIPopoverPresentationControllerDelegate) {
        let settingsVC = FlowLayoutSettingsController.init(scrollDirection: collectionViewLayout.scrollDirection, lineAlignment: collectionViewLayout.lineAlignment, interitemAlignment: collectionViewLayout.interitemAlignment)
        let navigationController = UINavigationController.init(rootViewController: settingsVC)
        
        navigationController.preferredContentSize = CGSize.init(width: 200, height: 390)
        navigationController.isModalInPopover = false
        navigationController.modalPresentationStyle = .popover
        
        let popoverPC = navigationController.popoverPresentationController!
        popoverPC.sourceView = view
        popoverPC.sourceRect = view.bounds
        popoverPC.delegate = delegate
        popoverPC.permittedArrowDirections = .any
        popoverPC.backgroundColor = UIColor.white
        UIApplication.shared.keyWindow?.rootViewController?.present(navigationController, animated: true, completion: nil)
    }
    
    var scrollDirection: UICollectionViewScrollDirection
    var lineAlignment: CollectionViewFlowLayout.LineAlignment
    var interitemAlignment: CollectionViewFlowLayout.InteritemAlignment
    
    init(scrollDirection: UICollectionViewScrollDirection, lineAlignment: CollectionViewFlowLayout.LineAlignment, interitemAlignment: CollectionViewFlowLayout.InteritemAlignment) {
        self.scrollDirection = scrollDirection
        self.lineAlignment = lineAlignment
        self.interitemAlignment = interitemAlignment
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let dataArray: [(header: String, items: [Any])] = [
        (header: "【滚动方向】", items: [
            UICollectionViewScrollDirection.horizontal,
            UICollectionViewScrollDirection.vertical
            ] as [Any]),
        (header: "【行对齐方式】", items: [
            CollectionViewFlowLayout.LineAlignment.leading,
            CollectionViewFlowLayout.LineAlignment.center,
            CollectionViewFlowLayout.LineAlignment.trailing,
            CollectionViewFlowLayout.LineAlignment.justified,
            CollectionViewFlowLayout.LineAlignment.justifiedCenter,
            CollectionViewFlowLayout.LineAlignment.justifiedTrailing
            ] as [Any]),
        (header: "【元素对齐方式】", items: [
            CollectionViewFlowLayout.InteritemAlignment.ascender,
            CollectionViewFlowLayout.InteritemAlignment.median,
            CollectionViewFlowLayout.InteritemAlignment.descender
            ] as [Any])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        tableView.estimatedRowHeight = 30.0
        tableView.estimatedSectionHeaderHeight = 30.0
        tableView.estimatedSectionFooterHeight = 1.0
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .white
        tableView.layoutMargins = .zero
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let item = dataArray[indexPath.section].items[indexPath.row]
        cell.textLabel?.text = String.init(describing: item)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        cell.textLabel?.textColor = UIColor.darkGray
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
        
        switch indexPath.section {
        case 0:
            if item as! UICollectionViewScrollDirection == self.scrollDirection {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        case 1:
            if item as! CollectionViewFlowLayout.LineAlignment == self.lineAlignment {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        case 2:
            if item as! CollectionViewFlowLayout.InteritemAlignment == self.interitemAlignment {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        default:
            fatalError("")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")!
        header.textLabel!.text = dataArray[section].header
        return header
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel!.font = UIFont.boldSystemFont(ofSize: 12.0)
        header.textLabel!.textColor = UIColor.lightGray
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataArray[indexPath.section].items[indexPath.row]
        switch indexPath.section {
        case 0: self.scrollDirection = item as! UICollectionViewScrollDirection
            
        case 1: self.lineAlignment = item as! CollectionViewFlowLayout.LineAlignment
            
        case 2: self.interitemAlignment =  item as! CollectionViewFlowLayout.InteritemAlignment
        default:
            fatalError("")
        }
        tableView.reloadSections([indexPath.section], with: .automatic)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30.0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
}


extension UICollectionViewScrollDirection: CustomStringConvertible {
    public var description: String {
        switch self {
        case .horizontal: return "horizontal"
        case .vertical: return "vertical"
        }
    }
}




