//
//  ChatViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/17.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var typingBaseView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        typingBaseView.layer.cornerRadius = 17
    }
    
    @IBAction func dismissButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
