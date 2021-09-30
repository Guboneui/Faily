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
    @IBOutlet weak var signUpLabel: UILabel!
    
    lazy var viewModel: LoginViewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        viewModel.loginView = self
        viewModelMethod()
    }
    
    func configUI() {
        self.navigationItem.backButtonTitle = ""
        self.title = "로그인"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        
        
        emailTextField.delegate = self
        emailTextField.returnKeyType = .next
        emailTextField.keyboardType = .alphabet
        
        passwordTextField.delegate = self
        passwordTextField.returnKeyType = .done
        passwordTextField.keyboardType = .alphabet
        
        let signUpTapGesture = UITapGestureRecognizer(target: self, action: #selector(signUpAction))
        signUpLabel.isUserInteractionEnabled = true
        signUpLabel.addGestureRecognizer(signUpTapGesture)
    }
    
    @objc func signUpAction(sender: UITapGestureRecognizer) {
        print("로그인 클릭")
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        let signUpVC = storyBoard.instantiateViewController(withIdentifier: "SignUpWithUserInfoViewController") as! SignUpWithUserInfoViewController
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction func showPasswordButtonAction(_ sender: Any) {
        passwordTextField.isSecureTextEntry.toggle()
        if passwordTextField.isSecureTextEntry == true {
            showPasswordButton.setImage(UIImage(named: "eye_close"), for: .normal)
        } else {
            showPasswordButton.setImage(UIImage(named: "eye_open"), for: .normal)
        }
    }
    
    @IBAction func deleteEmailButtonAction(_ sender: Any) {
        emailTextField.text = ""
    }
    
    @IBAction func reSettingPasswordButtonAction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        let changePasswordVC = storyBoard.instantiateViewController(withIdentifier: "ChangePasswordCheckEmailViewController") as! ChangePasswordCheckEmailViewController
        self.navigationController?.pushViewController(changePasswordVC, animated: true)
    }
    
    
    @IBAction func loginButtonAction(_ sender: Any) {
        
//        guard let user_email = emailTextField.text?.trim, user_email.isExists else {
//            self.presentAlert(title: "이메일을 입력 해주세요")
//            return
//        }
//
//        guard let user_pw = passwordTextField.text?.trim, user_pw.isExists else {
//            self.presentAlert(title: "비밀번호를 입력 해주세요")
//            return
//        }
//
//
//
//        let param = LoginRequest(user_email: user_email, user_pw: user_pw)
//        viewModel.postLogin(param)
        
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        let agreeAuthorityVC = storyBoard.instantiateViewController(withIdentifier: "AgreeAuthorityViewController") as! AgreeAuthorityViewController
        agreeAuthorityVC.modalPresentationStyle = .overCurrentContext
        self.present(agreeAuthorityVC, animated: true, completion: nil)
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

extension LoginViewController {
    
    func viewModelMethod() {
        viewModel.showAlert = { [self] message in
            let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
        
        viewModel.goAlertView = {
            let storyBoard = UIStoryboard(name: "Login", bundle: nil)
            let agreeAuthorityVC = storyBoard.instantiateViewController(withIdentifier: "AgreeAuthorityViewController") as! AgreeAuthorityViewController
            agreeAuthorityVC.modalPresentationStyle = .overCurrentContext
            self.present(agreeAuthorityVC, animated: true, completion: nil)
        }
    }
    
}
