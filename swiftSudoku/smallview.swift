
//  smallview.swift
//  数独辅助
//
//  Created by mac on 2018/5/10.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

class smallview: UIView ,UITextFieldDelegate{

    @IBOutlet weak var LeftUpText: UITextField!
    
    @IBOutlet weak var UpText: UITextField!
    
    @IBOutlet weak var RightUpText: UITextField!
    
    @IBOutlet weak var LeftText: UITextField!
    
    @IBOutlet weak var CountText: UITextField!
    
    @IBOutlet weak var RightText: UITextField!
    
    @IBOutlet weak var LeftDottomText: UITextField!
    
    @IBOutlet weak var DottomText: UITextField!
    
    @IBOutlet weak var RightBottomText: UITextField!
    
    var TextArray : [UITextField]!
    
   class func smallviewWihtXib() -> smallview {
    
    let view : smallview = Bundle.main.loadNibNamed("smallview", owner: nil, options:nil)?.first as! smallview

    view.LeftUpText.delegate = view
    view.UpText.delegate = view
    view.RightUpText.delegate = view
    view.LeftText.delegate = view
    view.CountText.delegate = view
    view.RightText.delegate = view
    view.LeftDottomText.delegate = view
    view.DottomText.delegate = view
    view.RightBottomText.delegate = view
    view.TextArray = [view.LeftUpText,view.UpText,view.RightUpText,view.LeftText,view.CountText,view.RightText,view.LeftDottomText,view.DottomText,view.RightBottomText]
    return view
    
    }
  
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.text = string
        self.endEditing(true)
        return true
    }
 
    func loadviewData() -> [Int] {
        var dataArray = [] as! [Int]
        for text in TextArray {
            if text.text != "" {
                dataArray.append(Int(text.text!)! - 1)
            } else {
                dataArray.append(-1)
            }
        }
        return dataArray
    }
    
    func DisplayResults( _ DataArray : [Int]) {
        for i in 0...8 {
            self.TextArray[i].text = String(DataArray[i] + 1)
        }
    }
    func loadNil() {
        for i in 0...8 {
            self.TextArray[i].text = ""
        }
    }
    
}
