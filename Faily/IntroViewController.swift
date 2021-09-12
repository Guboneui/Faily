//
//  ViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/04.
//

import UIKit

class IntroViewController: UIViewController {

    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        
        
        
    }
    
    func configUI() {
        signupButton.layer.cornerRadius = 6
        signupButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        signupButton.layer.shadowOpacity = 0.25
        
        let loginTapGesture = UITapGestureRecognizer(target: self, action: #selector(loginAction))
        loginLabel.isUserInteractionEnabled = true
        loginLabel.addGestureRecognizer(loginTapGesture)
    }
    
    @objc func loginAction(sender: UITapGestureRecognizer) {
        print("로그인 클릭")
    }
    
    @IBAction func signupButtonAction(_ sender: Any) {
        print("회원가입 버튼 클릭")
    }
    


}

