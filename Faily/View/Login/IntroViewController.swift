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
        self.navigationItem.backButtonTitle = ""
        
        let loginTapGesture = UITapGestureRecognizer(target: self, action: #selector(loginAction))
        loginLabel.isUserInteractionEnabled = true
        loginLabel.addGestureRecognizer(loginTapGesture)
    }
    
    @objc func loginAction(sender: UITapGestureRecognizer) {
        print("로그인 클릭")
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        let loginVC = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func signupButtonAction(_ sender: Any) {
        print("회원가입 버튼 클릭")
        
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        let signUpVC = storyBoard.instantiateViewController(withIdentifier: "SignUpWithUserInfoViewController") as! SignUpWithUserInfoViewController
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
}

