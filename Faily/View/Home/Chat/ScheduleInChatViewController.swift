//
//  ScheduleInChatViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/10/15.
//

import UIKit
import PanModal

class ScheduleInChatViewController: UIViewController {

    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
    @IBOutlet weak var dailySwitch: UISwitch!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    
    override func loadView() {
        super.loadView()
        dailySwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShowNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHideNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(dismissTapGesture))
        backgroundImageView.isUserInteractionEnabled = true
        backgroundImageView.addGestureRecognizer(dismissGesture)
        
    }
    
    @objc func handleKeyboardShowNotification(_ sender: Notification) {
        
        let userInfo:NSDictionary = sender.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        print(keyboardRectangle)
        
       
            bottomMargin.constant =  -keyboardRectangle.height 
         
        
    }
    
    @objc func handleKeyboardHideNotification(_ sender: Notification) {
        
        let userInfo:NSDictionary = sender.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        print(keyboardRectangle)
        
        
        bottomMargin.constant = 0

        
    }
    
    
    @objc func dismissTapGesture(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }

}

