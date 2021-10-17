//
//  ParticipantViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/16.
//

import UIKit
import RxCocoa
import RxSwift

class ParticipantViewController: UIViewController {

    
    @IBOutlet weak var firstAuthTextField: RoundTextField!
    @IBOutlet weak var secondAuthTextField: RoundTextField!
    @IBOutlet weak var thirdAuthTextField: RoundTextField!
    @IBOutlet weak var fourthAuthTextField: RoundTextField!
    @IBOutlet weak var goMainButton: PinkMainButton!
    
    var digitTextFields: [UITextField] = []
    let disposeBag = DisposeBag()
    var userInputAuthNum: String = ""
    
    lazy var viewModel: EntryViewModel = EntryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        digitTextFields = [firstAuthTextField, secondAuthTextField, thirdAuthTextField, fourthAuthTextField]
        textCheckWithRXSwift()
        viewModelMethod()
        // Do any additional setup after loading the view.
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
                        self.enableButton(button: self.goMainButton, enabled: false)
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
                        
                        self.enableButton(button: self.goMainButton, enabled: enabled)
                    })
                    .disposed(by: disposeBag)
        
    }
    func enableButton(button: UIButton, enabled:Bool) {
        button.isEnabled = enabled
        button.alpha = enabled ? 1.0 : 0.25
    }
    func configUI() {
        self.navigationItem.backButtonTitle = ""
        self.title = "시작하기"
        firstAuthTextField.keyboardType = .alphabet
        secondAuthTextField.keyboardType = .alphabet
        thirdAuthTextField.keyboardType = .alphabet
        fourthAuthTextField.keyboardType = .alphabet
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
    }
    @IBAction func goMainHomeButtonAction(_ sender: Any) {
        
        let param = EntryRequest(group_code: self.userInputAuthNum)
        viewModel.postEntryChat(param)
    }
    

}


extension ParticipantViewController {
    
    func viewModelMethod() {
        viewModel.showAlert = { [self] message in
            let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
    
        viewModel.goMainView = {
            let storyBoard = UIStoryboard(name: "Home", bundle: nil)
            let homeNAV = storyBoard.instantiateViewController(identifier: "HomeNav")
            self.changeRootViewController(homeNAV)
        }
    }
    
}
