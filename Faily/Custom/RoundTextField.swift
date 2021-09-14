//
//  RoundTextField.swift
//  Faily
//
//  Created by 구본의 on 2021/09/15.
//

import Foundation
import UIKit

class RoundTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCustomTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setCustomTextField()
    }
    
    func setCustomTextField() {
        self.backgroundColor = UIColor.FailyColor.grayscale_5
        self.layer.cornerRadius = self.frame.height / 2
        self.keyboardType = .numberPad
        self.tintColor = UIColor.FailyColor.mainPinkColor
    }
}
