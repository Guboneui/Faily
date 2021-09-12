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
    }
    
    func configUI() {
        self.title = "이메일로 가입하기"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        
        firstAuthTextField.layer.cornerRadius = firstAuthTextField.frame.height / 2
        firstAuthTextField.keyboardType = .numberPad
        
        secondAuthTextField.layer.cornerRadius = secondAuthTextField.frame.height / 2
        secondAuthTextField.keyboardType = .numberPad
        
        thirdAuthTextField.layer.cornerRadius = thirdAuthTextField.frame.height / 2
        thirdAuthTextField.keyboardType = .numberPad
        
        fourthAuthTextField.layer.cornerRadius = fourthAuthTextField.frame.height / 2
        fourthAuthTextField.keyboardType = .numberPad
    }

}
