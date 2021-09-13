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
        
        passwordBaseView.layer.cornerRadius = 8
        passwordBaseView.layer.borderWidth = 1
        passwordBaseView.layer.borderColor = UIColor.FailyColor.viewBorderColor.cgColor
        
        passwordTextField.delegate = self
        passwordTextField.returnKeyType = .next
        passwordTextField.keyboardType = .alphabet
        
        checkPasswordBaseView.layer.cornerRadius = 8
        checkPasswordBaseView.layer.borderWidth = 1
        checkPasswordBaseView.layer.borderColor = UIColor.FailyColor.viewBorderColor.cgColor
        
        checkPasswordTextField.delegate = self
        checkPasswordTextField.returnKeyType = .done
        checkPasswordTextField.keyboardType = .alphabet
        
        changePasswordButton.layer.cornerRadius = 6
        changePasswordButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        changePasswordButton.layer.shadowOpacity = 0.25
        
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
