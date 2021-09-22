//
//  AddDateViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/23.
//

import UIKit
import PanModal

class AddDateViewController: UIViewController {
    
    @IBOutlet weak var alwaysSwitch: UISwitch!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    @IBOutlet weak var memoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoTextView.delegate = self
        memoTextView.text = "메모"
        memoTextView.textColor = UIColor.FailyColor.placeholder_gray
        alwaysSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        endDatePicker.minimumDate = startDatePicker.date
    }
    
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "저장되었습니다.", message: "", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "확인", style: .default, handler: {[self] _ in
            dismiss(animated: true, completion: nil)
        })
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}


extension AddDateViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {

        textViewSetupView()
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if memoTextView.text == "" {
            textViewSetupView()
        }
    }



    func textViewSetupView() {
        if memoTextView.text == "메모" {
            memoTextView.text = ""
            memoTextView.textColor = UIColor.black
        } else if memoTextView.text == ""{
            memoTextView.text = "메모"
            memoTextView.textColor = UIColor.FailyColor.placeholder_gray
        }
    }
    
    
    
    
    
}
