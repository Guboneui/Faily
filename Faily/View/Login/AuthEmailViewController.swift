//
//  AuthEmailViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/13.
//

import UIKit
import RxSwift
import RxCocoa

class AuthEmailViewController: UIViewController {

    
    @IBOutlet weak var firstAuthTextField: UITextField!
    @IBOutlet weak var secondAuthTextField: UITextField!
    @IBOutlet weak var thirdAuthTextField: UITextField!
    @IBOutlet weak var fourthAuthTextField: UITextField!
    
    @IBOutlet weak var checkEmailAuthNumButton: UIButton!
    
    var digitTextFields: [UITextField] = []
    let disposeBag = DisposeBag()
    
    var userInputAuthNum: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        digitTextFields = [firstAuthTextField, secondAuthTextField, thirdAuthTextField, fourthAuthTextField]
        textCheckWithRXSwift()
//        firstAuthTextField.delegate = self
//        secondAuthTextField.delegate = self
//        thirdAuthTextField.delegate = self
//        fourthAuthTextField.delegate = self
    }
    
    func configUI() {
        self.navigationItem.backButtonTitle = ""
        self.title = "이메일로 가입하기"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        
//        secondAuthTextField.isEnabled = false
//        thirdAuthTextField.isEnabled = false
//        fourthAuthTextField.isEnabled = false
//        
       
    }
    
    func textCheckWithRXSwift() {
        let responders: [(digitTextField: UITextField, potentialNextResponder: UITextField?)] = [
            (firstAuthTextField, secondAuthTextField),
            (secondAuthTextField, thirdAuthTextField),
            (thirdAuthTextField, fourthAuthTextField),
            (fourthAuthTextField, nil)
        ]
        
        for (digitTextField, potentialNextResponder) in responders {
            if let nextResponder = potentialNextResponder {
                digitTextField.rx.controlEvent([.editingChanged])
                    .asObservable()
                    .subscribe(onNext: {
                        nextResponder.becomeFirstResponder()
                    }).disposed(by: disposeBag)
            } else {
                digitTextField.rx.controlEvent([.editingChanged])
                    .asObservable()
                    .subscribe(onNext: { [self] in
                        digitTextField.resignFirstResponder()
                        userInputAuthNum = firstAuthTextField.text! + secondAuthTextField.text! + thirdAuthTextField.text! + fourthAuthTextField.text!
                        print("사용자가 입력한 인증번호는 \(userInputAuthNum) 입니다.")
                        
                    }).disposed(by: disposeBag)
            }
        }
        
        for digitTextField in digitTextFields {
                    digitTextField.rx.controlEvent(.editingDidBegin)
                    .asObservable()
                    .subscribe(onNext: { [unowned self] _ in
                        digitTextField.text = ""
                        self.enableButton(button: self.checkEmailAuthNumButton, enabled: false)
                    })
                    .disposed(by: disposeBag)
                }
        
        
        let digitObservables = digitTextFields.map { $0.rx.text.map { $0 ?? "" } }
                
                Observable.combineLatest(digitObservables)
                    .subscribe(onNext: { [unowned self] in
                        var enabled = true
                        
                        for textField in $0 {
                            if textField.count < 1 {
                                enabled = false
                            }
                        }
                        
                        self.enableButton(button: self.checkEmailAuthNumButton, enabled: enabled)
                    })
                    .disposed(by: disposeBag)
        
    }
    func enableButton(button: UIButton, enabled:Bool) {
        button.isEnabled = enabled
        button.alpha = enabled ? 1.0 : 0.25
    }
        
        
    


    
//      RXSwift 사용을 위한 주석 처리
//    @IBAction func firstAuthTextFieldAction(_ sender: Any) {
//        checkMaxLength(firstAuthTextField, maxLength: 1)
//    }
//
//    @IBAction func secondAuthTextFieldAction(_ sender: Any) {
//        checkMaxLength(secondAuthTextField, maxLength: 1)
//    }
//
//
//    @IBAction func thirdAuthTextFieldAction(_ sender: Any) {
//        checkMaxLength(thirdAuthTextField, maxLength: 1)
//    }
//
//    @IBAction func fourthAuthTextFieldAction(_ sender: Any) {
//        checkMaxLength(fourthAuthTextField, maxLength: 1)
//    }
    
}

//extension AuthEmailViewController: UITextFieldDelegate{
//
//
//
//    func textFieldDidChangeSelection(_ textField: UITextField) {
//
//        if textField == firstAuthTextField {
//            if textField.text!.count >= 1 {
//                secondAuthTextField.isEnabled = true
//                secondAuthTextField.becomeFirstResponder()
//
//            }
//
//
//        } else if textField == secondAuthTextField {
//            if textField.text!.count >= 1 {
//                thirdAuthTextField.isEnabled = true
//                thirdAuthTextField.becomeFirstResponder()
//            }
//        } else if textField == thirdAuthTextField {
//            if textField.text!.count >= 1 {
//                fourthAuthTextField.isEnabled = true
//                fourthAuthTextField.becomeFirstResponder()
//            }
//        } else if textField == fourthAuthTextField {
//            if textField.text!.count >= 1 {
//                fourthAuthTextField.endEditing(true)
//            }
//        }
//
//    }
//
//    func checkMaxLength(_ textField: UITextField!, maxLength: Int) {
//        if (textField.text?.count ?? 0 > maxLength) {
//            textField.deleteBackward()
//        }
//    }
//}
