//
//  CATransition.swift
//  Faily
//
//  Created by 구본의 on 2021/10/12.
//

import Foundation
import UIKit

extension CATransition {
    func fadeTransition() -> CATransition {
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight

        return transition
    }
}
