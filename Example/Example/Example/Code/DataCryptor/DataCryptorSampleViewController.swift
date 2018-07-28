//
//  DataCryptorSampleViewController.swift
//  Example
//
//  Created by mlibai on 2018/2/7.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit
import XZKit



class DataCryptorSampleViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var operationSegmentedControl: UISegmentedControl!
    @IBOutlet weak var paddingSegmentedControl: UISegmentedControl!
    @IBOutlet weak var algorithmSegmentedControl: UISegmentedControl!
    @IBOutlet weak var modeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var keyTextField: UITextField!
    @IBOutlet weak var vectorTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultTypeSegmentedControl: UISegmentedControl!
    
    func canReadData(_ data: inout Data?) -> Bool {
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.title = "DataCryptor"
    }

    @IBAction func submitButtonAction(_ sender: UIButton) {
        guard let key = keyTextField.text else { return }
        
        let algorithm: DataCryptor.Algorithm = {
            switch algorithmSegmentedControl.selectedSegmentIndex {
            case 1: return .DES(key)
            case 2: return .TripleDES(key)
            case 3: return .CAST(key)
            case 4: return .RC2(key)
            case 5: return .RC4(key)
            case 6: return .Blowfish(key)
            default: return .AES(key)
            }
        }()
        
        let operation: DataCryptor.Operation = {
            switch operationSegmentedControl.selectedSegmentIndex {
            case 1: return DataCryptor.Operation.decrypt
            default: return DataCryptor.Operation.encrypt
            }
        }()
        
        let mode: DataCryptor.Mode = {
            let vector = vectorTextField.text;
            switch modeSegmentedControl.selectedSegmentIndex {
            case 1: return .CBC(vector)
            case 2: return .CFB(vector)
            case 3: return .CTR(vector)
                
            case 6: return .OFB(vector)
            case 7: return .XTS(vector)
            case 8: return .RC4
            case 9: return .CFB8(vector)
            default: return .ECB
            }
        }()
        
        let padding: DataCryptor.Padding = {
            switch paddingSegmentedControl.selectedSegmentIndex {
            case 1: return DataCryptor.Padding.none
            default: return DataCryptor.Padding.PKCS7
            }
        }()
        
        guard let data: Data = { () -> Data? in
            guard let dataString = self.textView?.text else { return nil }
            if operation == .decrypt {
                if self.resultTypeSegmentedControl.selectedSegmentIndex == 1 {
                    return Data.init(base64Encoded: dataString)
                } else {
                    return Data.init(hexadecimalEncoded: dataString)
                }
            } else {
                return dataString.data(using: .utf8)
            }
            }() else {
                resultLabel.text = "发生错误：数据格式不正确！"
                return
        }
        
        do {
            let result = try DataCryptor.crypt(data, algorithm: algorithm, operation: operation, mode: mode, padding: padding)
            
            if operation == .encrypt {
                if resultTypeSegmentedControl.selectedSegmentIndex == 1 {
                    resultLabel.text = result.base64EncodedString()
                } else {
                    resultLabel.text = result.hexadecimalEncodedString
                }
            } else {
                resultLabel.text = String.init(data: result, encoding: .utf8)
            }
        } catch {
            resultLabel.text = "发生错误：\(error)"
        }
        
    }
    

}
