//
//  AddDateNavigationController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/23.
//

import Foundation
import UIKit
import PanModal

class AddDateNavigationController: UINavigationController, PanModalPresentable {
    override func popViewController(animated: Bool) -> UIViewController? {
        let vc = super.popViewController(animated: animated)
        panModalSetNeedsLayoutUpdate()
        return vc
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        panModalSetNeedsLayoutUpdate()
    }
    
    var panScrollable: UIScrollView? {
        return (topViewController as? PanModalPresentable)?.panScrollable
    }

    var longFormHeight: PanModalHeight {
        return .maxHeight
    }

    var shortFormHeight: PanModalHeight {
        return longFormHeight
    }
    
    var cornerRadius: CGFloat {
        return 20.0
    }
}
