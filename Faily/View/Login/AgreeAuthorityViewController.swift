//
//  AgreeAuthorityViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/14.
//

import UIKit

class AgreeAuthorityViewController: UIViewController {

    
    @IBOutlet weak var agreeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    func configUI() {
        agreeButton.layer.cornerRadius = 6
        agreeButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        agreeButton.layer.shadowOpacity = 0.25
    }

    @IBAction func agreeButtonAction(_ sender: Any) {
    }
    
}
