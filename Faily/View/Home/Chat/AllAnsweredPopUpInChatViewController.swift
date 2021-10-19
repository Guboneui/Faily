//
//  AllAnsweredPopUpInChatViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/10/19.
//

import UIKit

class AllAnsweredPopUpInChatViewController: UIViewController {

    
    
    
    @IBOutlet var mainBaseView: UIView!
    @IBOutlet weak var popUpBaseView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        addGesture()
    }
    

    func configUI() {
        popUpBaseView.layoutIfNeeded()
        popUpBaseView.isUserInteractionEnabled = false
        popUpBaseView.layer.cornerRadius = 15
        self.makeShadow(popUpBaseView)
    }
    
    func addGesture() {
        let dismissTapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissAction))
        mainBaseView.isUserInteractionEnabled = true
        mainBaseView.addGestureRecognizer(dismissTapGesture)
    }
    
    @objc func dismissAction(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: false, completion: nil)
    }
    

}
