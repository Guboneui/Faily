//
//  AuthEmailViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/13.
//

import UIKit

class AuthEmailViewController: UIViewController {

    
    @IBOutlet weak var firstAuthTextField: UITextField!
    @IBOutlet weak var secondAuthTextField: UITextField!
    @IBOutlet weak var thirdAuthTextField: UITextField!
    @IBOutlet weak var fourthAuthTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        firstAuthTextField.delegate = self
        secondAuthTextField.delegate = self
        thirdAuthTextField.delegate = self
        fourthAuthTextField.delegate = self
    }
    
    func configUI() {
        self.title = "이메일로 가입하기"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        
        firstAuthTextField.layer.cornerRadius = firstAuthTextField.frame.height / 2
        firstAuthTextField.keyboardType = .numberPad
        
        secondAuthTextField.layer.cornerRadius = secondAuthTextField.frame.height / 2
        secondAuthTextField.keyboardType = .numberPad
        secondAuthTextField.isEnabled = false
        
        thirdAuthTextField.layer.cornerRadius = thirdAuthTextField.frame.height / 2
        thirdAuthTextField.keyboardType = .numberPad
        thirdAuthTextField.isEnabled = false
        
        fourthAuthTextField.layer.cornerRadius = fourthAuthTextField.frame.height / 2
        fourthAuthTextField.keyboardType = .numberPad
        fourthAuthTextField.isEnabled = false
    }
    
    
    @IBAction func firstAuthTextFieldAction(_ sender: Any) {
        checkMaxLength(firstAuthTextField, maxLength: 1)
    }
    
    @IBAction func secondAuthTextFieldAction(_ sender: Any) {
        checkMaxLength(secondAuthTextField, maxLength: 1)
    }
    
    
    @IBAction func thirdAuthTextFieldAction(_ sender: Any) {
        checkMaxLength(thirdAuthTextField, maxLength: 1)
    }
    
    @IBAction func fourthAuthTextFieldAction(_ sender: Any) {
        checkMaxLength(fourthAuthTextField, maxLength: 1)
    }
    
}

extension AuthEmailViewController: UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if textField == firstAuthTextField {
            if textField.text!.count >= 1 {
                secondAuthTextField.isEnabled = true
                secondAuthTextField.becomeFirstResponder()
            }
        } else if textField == secondAuthTextField {
            if textField.text!.count >= 1 {
                thirdAuthTextField.isEnabled = true
                thirdAuthTextField.becomeFirstResponder()
            }
        } else if textField == thirdAuthTextField {
            if textField.text!.count >= 1 {
                fourthAuthTextField.isEnabled = true
                fourthAuthTextField.becomeFirstResponder()
            }
        } else if textField == fourthAuthTextField {
            if textField.text!.count >= 1 {
                fourthAuthTextField.endEditing(true)
            }
        }
 
    }
    
    func checkMaxLength(_ textField: UITextField!, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }
}
