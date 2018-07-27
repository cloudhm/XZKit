//
//  APIConcurrencyPolicyViewController.swift
//  Example
//
//  Created by mlibai on 2018/7/9.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit
import XZKit

protocol APIConcurrencyPolicyViewControllerDelegate: NSObjectProtocol {
    func viewController(_ viewController: APIConcurrencyPolicyViewController, didSelect policy: APIConcurrencyPolicy) -> Void
}

class APIConcurrencyPolicyViewController: UITableViewController {
    
    weak var delegate: APIConcurrencyPolicyViewControllerDelegate?
    
    let dataArray = [
        APIConcurrencyPolicy.default, APIConcurrencyPolicy.cancelOthers, APIConcurrencyPolicy.ignoreCurrent,
        APIConcurrencyPolicy.waitUntilAllDone, APIConcurrencyPolicy.waitWithHighPriority
    ]
    
    var selectedPolicy: APIConcurrencyPolicy
    
    init(_ selectedPolicy: APIConcurrencyPolicy) {
        self.selectedPolicy = selectedPolicy
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.title = "APIConcurrencyPolicy"
        self.navigationBar.backButton?.setTitle("返回", for: .normal)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let policy = dataArray[indexPath.row]
        
        cell.textLabel!.text = String.init(describing: dataArray[indexPath.row])
        
        if policy == selectedPolicy {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.viewController(self, didSelect: self.dataArray[indexPath.row])
        self.navigationController!.popViewController(animated: true)
    }
}
