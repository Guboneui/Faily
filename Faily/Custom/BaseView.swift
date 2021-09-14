//
//  BaseView.swift
//  Faily
//
//  Created by 구본의 on 2021/09/14.
//

import Foundation
import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCustomView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setCustomView()
    }
    
    func setCustomView() {
        self.backgroundColor = UIColor.FailyColor.baseBackGroundColor
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.FailyColor.viewBorderColor.cgColor
    }
}
