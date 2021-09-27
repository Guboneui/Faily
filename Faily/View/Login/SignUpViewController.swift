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

    var getUserName: String?
    var getUserBirthDay: String?
    
    var agreeAllState = false
    var useTermsState = false
    var personalInfoState = false
    
    lazy var viewModel: SignUpViewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.signUpView = self
        configUI()
    }
    
    func configUI() {
        self.navigationItem.backButtonTitle = ""
        self.title = "이메일로 가입하기"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        
        emailTextField.delegate = self
        emailTextField.returnKeyType = .next
        emailTextField.keyboardType = .alphabet
        
        passwordTextField.delegate = self
        passwordTextField.returnKeyType = .next
        passwordTextField.keyboardType = .alphabet
        
        checkPasswordTextField.delegate = self
        checkPasswordTextField.returnKeyType = .done
        checkPasswordTextField.keyboardType = .alphabet

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
    
    
    
    
    
    @IBAction func signUpButtonAction(_ sender: Any) {

        //비밀번호 정규식 설정
        let checkPassword = isValidPassword(password: passwordTextField.text!)
        if checkPassword == true {
            print("유효성 검사 통과")
        } else {
            print("유효성 검사 실패")
            return
        }

        if passwordTextField.text! == checkPasswordTextField.text! {
            print("비밀번호 일치")
        } else {
            print("비밀번호 불일치")
            return
        }
        
        let email = emailTextField.text!
        let password = checkPasswordTextField.text!
        
        let param = SignUpRequest(user_email: email, user_pw: password, user_name: self.getUserName!, user_bdate: self.getUserBirthDay!)
        viewModel.postSignUp(param)


        
    }
    
    func isValidPassword(password: String) -> Bool {
           let passwordRegEx = "^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,16}"
           let passwordCheck = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
           return passwordCheck.evaluate(with: password)
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
            let emailAccurate = isValidEmail(email: textField.text!)
            if emailAccurate == true {
                emailCheckImage.image = UIImage(named: "check_Fill")
            } else {
                emailCheckImage.image = UIImage(named: "check_Default")
            }
        }
    }
    
    func isValidEmail(email:String) -> Bool {
       let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
       let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
       return emailTest.evaluate(with: email)
    }
}


extension SignUpViewController{
    func viewModelMethod() {
        viewModel.showAlert = { [self] message in
            let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
        
        viewModel.goAuthEmailView = {
            let storyBoard = UIStoryboard(name: "Login", bundle: nil)
            let authEmailVC = storyBoard.instantiateViewController(withIdentifier: "AuthEmailViewController") as! AuthEmailViewController
            self.navigationController?.pushViewController(authEmailVC, animated: true)
        }
    }
}
