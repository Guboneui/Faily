//
//  LoginViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/13.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailBaseView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordBaseView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var showPasswordButton: UIButton!
    
    @IBOutlet weak var checkPasswordBaseView: UIView!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var showCheckPasswordButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBOutlet weak var useTermsLabel: UILabel!
    @IBOutlet weak var personalInfoLabel: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    func configUI() {
        
        self.title = "이메일로 가입하기"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        
        emailBaseView.layer.cornerRadius = 8
        emailBaseView.layer.borderWidth = 1
        emailBaseView.layer.borderColor = UIColor.FailyColor.viewBorderColor.cgColor
        
        emailTextField.delegate = self
        emailTextField.returnKeyType = .next
        
        
        passwordBaseView.layer.cornerRadius = 8
        passwordBaseView.layer.borderWidth = 1
        passwordBaseView.layer.borderColor = UIColor.FailyColor.viewBorderColor.cgColor
        
        passwordTextField.delegate = self
        passwordTextField.returnKeyType = .next
       
        
        checkPasswordBaseView.layer.cornerRadius = 8
        checkPasswordBaseView.layer.borderWidth = 1
        checkPasswordBaseView.layer.borderColor = UIColor.FailyColor.viewBorderColor.cgColor
        
        checkPasswordTextField.delegate = self
        checkPasswordTextField.returnKeyType = .done
        
        let useTermsTapGesture = UITapGestureRecognizer(target: self, action: #selector(useTermsAction))
        useTermsLabel.isUserInteractionEnabled = true
        useTermsLabel.addGestureRecognizer(useTermsTapGesture)
        
        let personalInfoTapGesture = UITapGestureRecognizer(target: self, action: #selector(personalInfoAction))
        personalInfoLabel.isUserInteractionEnabled = true
        personalInfoLabel.addGestureRecognizer(personalInfoTapGesture)
        
        signUpButton.layer.cornerRadius = 6
        signUpButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        signUpButton.layer.shadowOpacity = 0.25
        
    }
    
    @objc func useTermsAction(sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "서비스 이용약관", message: "", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func personalInfoAction(sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "개인정보 수집 및 이용 동의", message: "", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

    
    
    @IBAction func showPasswordButtonAction(_ sender: Any) {
        print(1)
        self.passwordTextField.isSecureTextEntry.toggle()
        if self.passwordTextField.isSecureTextEntry == true {
            self.showPasswordButton.setImage(UIImage(named: "eye_close"), for: .normal)
        } else {
            self.showPasswordButton.setImage(UIImage(named: "eye_open"), for: .normal)
        }
    }
    
    @IBAction func showCheckPasswordButtonAction(_ sender: Any) {
        print(2)
        self.checkPasswordTextField.isSecureTextEntry.toggle()
        if self.checkPasswordTextField.isSecureTextEntry == true {
            self.showCheckPasswordButton.setImage(UIImage(named: "eye_close"), for: .normal)
        } else {
            self.showCheckPasswordButton.setImage(UIImage(named: "eye_open"), for: .normal)
        }
    }
    
    
   

}


extension SignUpViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == emailTextField {
        passwordTextField.becomeFirstResponder()
    } else if textField == passwordTextField {
        checkPasswordTextField.becomeFirstResponder()
    } else {
        checkPasswordTextField.resignFirstResponder()
    }
    return true
  }
}
