//
//  SignUpWithUserInfoViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/16.
//

import UIKit

class SignUpWithUserInfoViewController: UIViewController {
    
    @IBOutlet weak var agreeAllButton: UIButton!
    @IBOutlet weak var useTermsButton: UIButton!
    @IBOutlet weak var showUseTermsLabel: UILabel!
    @IBOutlet weak var personalInfoButton: UIButton!
    @IBOutlet weak var showPersonalInfoLabel: UILabel!
    
    
    @IBOutlet weak var nameBaseView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var birthDayBaseView: UIView!
    @IBOutlet weak var birthDayTextField: UITextField!
    
    let datePicker = UIDatePicker()
    
    var agreeAllState = false
    var useTermsState = false
    var personalInfoState = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configDatePicker()
        // Do any additional setup after loading the view.
    }
    
    func configUI() {
        self.navigationItem.backButtonTitle = ""
        self.title = "이메일로 가입하기"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        
        nameTextField.delegate = self
        nameTextField.returnKeyType = .next
        
        birthDayTextField.delegate = self
        birthDayTextField.returnKeyType = .next
        
        let labelString = "보기"
        let textColor = UIColor.FailyColor.grayscale_2
        let underLineColor = UIColor.FailyColor.grayscale_2
        let underLineStyle = NSUnderlineStyle.single.rawValue

        let labelAtributes:[NSAttributedString.Key : Any]  = [
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.underlineStyle: underLineStyle,
            NSAttributedString.Key.underlineColor: underLineColor
        ]
        let underlineAttributedString = NSAttributedString(string: labelString, attributes: labelAtributes)

        let useTermsTapGesture = UITapGestureRecognizer(target: self, action: #selector(useTermsAction))
        showUseTermsLabel.isUserInteractionEnabled = true
        showUseTermsLabel.addGestureRecognizer(useTermsTapGesture)
        showUseTermsLabel.attributedText = underlineAttributedString
        
        let personalInfoTapGesture = UITapGestureRecognizer(target: self, action: #selector(personalInfoAction))
        showPersonalInfoLabel.isUserInteractionEnabled = true
        showPersonalInfoLabel.addGestureRecognizer(personalInfoTapGesture)
        showPersonalInfoLabel.attributedText = underlineAttributedString

    }
    
    func configDatePicker() {
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        datePicker.maximumDate = Date()
        datePicker.datePickerMode = .date
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelDatePicker))
        cancelButton.tintColor = UIColor.FailyColor.coral
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(doneDatePicker))
        
        let items = [cancelButton, flexSpace, doneButton]
        toolbar.items = items
        
        birthDayTextField.inputAccessoryView = toolbar
        birthDayTextField.inputView = datePicker
    }
    
    @objc func cancelDatePicker() {
        self.view.endEditing(true)
    }
    
    @objc func doneDatePicker () {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        birthDayTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
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
    
    
    @IBAction func nextSignUpViewButton(_ sender: Any) {
//        if personalInfoState == true && useTermsState == true {
//           
//        } else {
//            let alert = UIAlertController(title: "약관을 동의 해주세요", message: "", preferredStyle: .alert)
//            let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
//            alert.addAction(okButton)
//            self.present(alert, animated: true, completion: nil)
//        }
        
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        let signUpVC = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
}


extension SignUpWithUserInfoViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == nameTextField {
        birthDayTextField.becomeFirstResponder()
    } else {
        birthDayTextField.resignFirstResponder()
    }
    return true
  }
    

}
