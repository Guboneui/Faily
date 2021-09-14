//
//  PinkMainButton.swift
//  Faily
//
//  Created by 구본의 on 2021/09/15.
//

import Foundation
import UIKit

class PinkMainButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCustomButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setCustomButton()
    }
    
    func setCustomButton() {
        self.backgroundColor = UIColor.FailyColor.secondaryPinkColor
        self.layer.cornerRadius = 6
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = 0.25
    }
}
