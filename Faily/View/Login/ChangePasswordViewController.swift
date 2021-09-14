//
//  ChangePasswordViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/14.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    
    @IBOutlet weak var passwordBaseView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var showPasswordButton: UIButton!
    
    @IBOutlet weak var checkPasswordBaseView: UIView!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var showCheckPasswordButton: UIButton!
    
    @IBOutlet weak var changePasswordButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    func configUI() {
        self.navigationItem.backButtonTitle = ""
        self.title = "비밀번호 재설정"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        
     
        passwordTextField.delegate = self
        passwordTextField.returnKeyType = .next
        passwordTextField.keyboardType = .alphabet
    
        checkPasswordTextField.delegate = self
        checkPasswordTextField.returnKeyType = .done
        checkPasswordTextField.keyboardType = .alphabet
    }
    
    
    @IBAction func showPasswordButtonAction(_ sender: Any) {
        self.passwordTextField.isSecureTextEntry.toggle()
        if self.passwordTextField.isSecureTextEntry == true {
            self.showPasswordButton.setImage(UIImage(named: "eye_close"), for: .normal)
        } else {
            self.showPasswordButton.setImage(UIImage(named: "eye_open"), for: .normal)
        }
    }
    
    @IBAction func showCheckPasswordButtonAction(_ sender: Any) {
        self.checkPasswordTextField.isSecureTextEntry.toggle()
        if self.checkPasswordTextField.isSecureTextEntry == true {
            self.showCheckPasswordButton.setImage(UIImage(named: "eye_close"), for: .normal)
        } else {
            self.showCheckPasswordButton.setImage(UIImage(named: "eye_open"), for: .normal)
        }
    }
    
}


extension ChangePasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      if textField == passwordTextField {
          checkPasswordTextField.becomeFirstResponder()
      } else {
        checkPasswordTextField.resignFirstResponder()
      }
      return true
    }
}
