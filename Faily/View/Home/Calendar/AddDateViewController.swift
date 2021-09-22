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
    
    
    @IBAction func scheduleDivisionButtonAction(_ sender: Any) {
//        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
//        let scheduleDivisionVC = storyBoard.instantiateViewController(withIdentifier: "ScheduleDivisionViewController") as! ScheduleDivisionViewController
//        self.navigationController?.pushViewController(scheduleDivisionVC, animated: true)


        let alert = UIAlertController(title: "새로운 일정", message: "일정을 분류 해주세요", preferredStyle: .actionSheet)
        
        var birthdayImage = UIImage(named: "birthday_addDate")
        birthdayImage = birthdayImage?.imageWithSize(scaledToSize: CGSize(width: 32, height: 32))
        let addBirthDay = UIAlertAction(title: "기념일 및 생일", style: .default, handler: nil);
        addBirthDay.setValue(birthdayImage?.withRenderingMode(.alwaysOriginal), forKey: "image")
        addBirthDay.setValue(UIColor.black, forKey: "titleTextColor")
        alert.addAction(addBirthDay)
        
        var familyImage = UIImage(named: "family_addDate")
        familyImage = familyImage?.imageWithSize(scaledToSize: CGSize(width: 32, height: 32))
        let addFamily = UIAlertAction(title: "가족", style: .default, handler: nil);
        addFamily.setValue(familyImage?.withRenderingMode(.alwaysOriginal), forKey: "image")
        addFamily.setValue(UIColor.black, forKey: "titleTextColor")
        alert.addAction(addFamily)
        
        var personalImage = UIImage(named: "person_addDate")
        personalImage = personalImage?.imageWithSize(scaledToSize: CGSize(width: 32, height: 32))
        let addPersonal = UIAlertAction(title: "개인", style: .default, handler: nil);
        addPersonal.setValue(personalImage?.withRenderingMode(.alwaysOriginal), forKey: "image")
        addPersonal.setValue(UIColor.black, forKey: "titleTextColor")
        alert.addAction(addPersonal)
        
        var normalImage = UIImage(named: "normal_addDate")
        normalImage = normalImage?.imageWithSize(scaledToSize: CGSize(width: 32, height: 32))
        let addNormal = UIAlertAction(title: "일반", style: .default, handler: nil);
        addNormal.setValue(normalImage?.withRenderingMode(.alwaysOriginal), forKey: "image")
        addNormal.setValue(UIColor.black, forKey: "titleTextColor")
        alert.addAction(addNormal)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        cancel.setValue(UIColor.FailyColor.coral, forKey: "titleTextColor")
        alert.addAction(cancel)
        
        
        self.present(alert, animated: true, completion: nil)


      
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
