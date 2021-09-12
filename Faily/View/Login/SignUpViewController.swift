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
    @IBOutlet weak var emailCheckImage: UIImageView!
    
    
    @IBOutlet weak var passwordBaseView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var showPasswordButton: UIButton!
    
    @IBOutlet weak var checkPasswordBaseView: UIView!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var showCheckPasswordButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBOutlet weak var agreeAllButton: UIButton!
    
    @IBOutlet weak var useTermsButton: UIButton!
    @IBOutlet weak var useTermsLabel: UILabel!
    
    @IBOutlet weak var personalInfoButton: UIButton!
    @IBOutlet weak var personalInfoLabel: UILabel!
    
    
    var agreeAllState = false
    var useTermsState = false
    var personalInfoState = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    func configUI() {
        self.navigationItem.backButtonTitle = ""
        self.title = "이메일로 가입하기"
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
        passwordTextField.returnKeyType = .next
        passwordTextField.keyboardType = .alphabet
        
        checkPasswordBaseView.layer.cornerRadius = 8
        checkPasswordBaseView.layer.borderWidth = 1
        checkPasswordBaseView.layer.borderColor = UIColor.FailyColor.viewBorderColor.cgColor
        
        checkPasswordTextField.delegate = self
        checkPasswordTextField.returnKeyType = .done
        checkPasswordTextField.keyboardType = .alphabet
        
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
    
    
    @IBAction func agreeAllButtonAction(_ sender: Any) {
        print("전체 동의")
        agreeAllState.toggle()
        if agreeAllState == true {
            useTermsState = true
            personalInfoState = true
            agreeAllButton.setImage(UIImage(named: "checkBox_Fill"), for: .normal)
            useTermsButton.setImage(UIImage(named: "check_Fill"), for: .normal)
            personalInfoButton.setImage(UIImage(named: "check_Fill"), for: .normal)
        } else {
            useTermsState = false
            personalInfoState = false
            agreeAllButton.setImage(UIImage(named: "checkBox_Default"), for: .normal)
            useTermsButton.setImage(UIImage(named: "check_Default"), for: .normal)
            personalInfoButton.setImage(UIImage(named: "check_Default"), for: .normal)
        }
    }
    
    @IBAction func useTermsButtonAction(_ sender: Any) {
        useTermsState.toggle()
        if useTermsState == true {
            useTermsButton.setImage(UIImage(named: "check_Fill"), for: .normal)
        } else {
            useTermsButton.setImage(UIImage(named: "check_Default"), for: .normal)
        }
        
        if useTermsState == true && personalInfoState == true {
            agreeAllState = true
            agreeAllButton.setImage(UIImage(named: "checkBox_Fill"), for: .normal)
        } else {
            agreeAllState = false
            agreeAllButton.setImage(UIImage(named: "checkBox_Default"), for: .normal)
        }
    }
    
    @IBAction func personalInfoButtonAction(_ sender: Any) {
        personalInfoState.toggle()
        if personalInfoState == true {
            personalInfoButton.setImage(UIImage(named: "check_Fill"), for: .normal)
        } else {
            personalInfoButton.setImage(UIImage(named: "check_Default"), for: .normal)
        }
        if useTermsState == true && personalInfoState == true {
            agreeAllState = true
            agreeAllButton.setImage(UIImage(named: "checkBox_Fill"), for: .normal)
        } else {
            agreeAllState = false
            agreeAllButton.setImage(UIImage(named: "checkBox_Default"), for: .normal)
        }
    }
    
    
    @IBAction func signUpButtonAction(_ sender: Any) {
//        if personalInfoState == true && useTermsState == true {
//            let alert = UIAlertController(title: "정보 맞음", message: "", preferredStyle: .alert)
//            let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
//            alert.addAction(okButton)
//            self.present(alert, animated: true, completion: nil)
//        } else {
//            let alert = UIAlertController(title: "약관을 동의 해주세요", message: "", preferredStyle: .alert)
//            let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
//            alert.addAction(okButton)
//            self.present(alert, animated: true, completion: nil)
//        }
        
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        let authEmailVC = storyBoard.instantiateViewController(withIdentifier: "AuthEmailViewController") as! AuthEmailViewController
        self.navigationController?.pushViewController(authEmailVC, animated: true)
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
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == emailTextField {
            let emailAccurate = isValidEmail(testStr: textField.text!)
            if emailAccurate == true {
                emailCheckImage.image = UIImage(named: "check_Fill")
            } else {
                emailCheckImage.image = UIImage(named: "check_Default")
            }
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailTest.evaluate(with: testStr)
            }
}
