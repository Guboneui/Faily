//
//  HapticManager.swift
//  Faily
//
//  Created by 구본의 on 2021/09/16.
//

import Foundation
import UIKit

final class HapticsManager {
    static let shared = HapticsManager()
    
    private init() {}
    
    public func selectionVibrate() {
        DispatchQueue.main.async {
            let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
            selectionFeedbackGenerator.prepare()
            selectionFeedbackGenerator.selectionChanged()
        }
    }
    
    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        DispatchQueue.main.async {
            let notificationGenerator = UINotificationFeedbackGenerator()
            notificationGenerator.prepare()
            notificationGenerator.notificationOccurred(type)
        }
    }
    
    public func selection() {
        DispatchQueue.main.async {
            let selection = UISelectionFeedbackGenerator()
            selection.prepare()
            selection.selectionChanged()
        }
    }
    
    public func impact() {
        DispatchQueue.main.async {
            let impact = UIImpactFeedbackGenerator(style: .heavy)
            impact.prepare()
            impact.impactOccurred()
        }
    }
}

