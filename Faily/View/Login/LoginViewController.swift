//
//  LoginViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/13.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailBaseView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordBaseView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var showPasswordButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    func configUI() {
        self.title = "로그인"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        
        emailBaseView.layer.cornerRadius = 8
        emailBaseView.layer.borderWidth = 1
        emailBaseView.layer.borderColor = UIColor.FailyColor.viewBorderColor.cgColor
        
        emailTextField.delegate = self
        emailTextField.returnKeyType = .next
        emailTextField.keyboardType = .alphabet
        
        passwordBaseView.layer.cornerRadius = 8
        passwordBaseView.layer.borderWidth = 1
        passwordBaseView.layer.borderColor = UIColor.FailyColor.viewBorderColor.cgColor
        
        passwordTextField.delegate = self
        passwordTextField.returnKeyType = .done
        passwordTextField.keyboardType = .alphabet
        
        loginButton.layer.cornerRadius = 6
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        loginButton.layer.shadowOpacity = 0.25
    }
    
    @IBAction func showPasswordButtonAction(_ sender: Any) {
        passwordTextField.isSecureTextEntry.toggle()
        if passwordTextField.isSecureTextEntry == true {
            showPasswordButton.setImage(UIImage(named: "eye_close"), for: .normal)
        } else {
            showPasswordButton.setImage(UIImage(named: "eye_open"), for: .normal)
        }
    }
    
}


extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      if textField == emailTextField {
          passwordTextField.becomeFirstResponder()
      } else {
          passwordTextField.resignFirstResponder()
      }
      return true
    }
}
