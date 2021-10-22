//
//  AddDateViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/23.
//

import UIKit
import PanModal


protocol ReloadCalendarDelegate: AnyObject {
    func reloadCalendar()
}

class AddDateViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var alwaysSwitch: UISwitch!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    @IBOutlet weak var scheduleImage: UIImageView!
    @IBOutlet weak var repeatLabel: UILabel!
    @IBOutlet weak var memoTextView: UITextView!
    
    
    weak var delegate: ReloadCalendarDelegate?
    lazy var viewModel: AddScheduleViewModel = AddScheduleViewModel()
    
    
    var category: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoTextView.delegate = self
        memoTextView.text = "메모"
        memoTextView.textColor = UIColor.FailyColor.placeholder_gray
        alwaysSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        endDatePicker.minimumDate = startDatePicker.date
        
        
        viewModel.addScheduleView = self
        viewModelMethod()
    }
    
    
    @IBAction func scheduleDivisionButtonAction(_ sender: Any) {
//        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
//        let scheduleDivisionVC = storyBoard.instantiateViewController(withIdentifier: "ScheduleDivisionViewController") as! ScheduleDivisionViewController
//        self.navigationController?.pushViewController(scheduleDivisionVC, animated: true)


        let alert = UIAlertController(title: "일정 구분", message: "일정을 분류 해주세요", preferredStyle: .actionSheet)
        
        var birthdayImage = UIImage(named: "birthday_addDate")
        birthdayImage = birthdayImage?.imageWithSize(scaledToSize: CGSize(width: 32, height: 32))
        let addBirthDay = UIAlertAction(title: "기념일 및 생일", style: .default, handler: {[self] _ in
            scheduleImage.image = UIImage(named: "birthday_addDate")
            self.category = "기념일"
        })
        addBirthDay.setValue(birthdayImage?.withRenderingMode(.alwaysOriginal), forKey: "image")
        addBirthDay.setValue(UIColor.black, forKey: "titleTextColor")
        alert.addAction(addBirthDay)
        
        var familyImage = UIImage(named: "family_addDate")
        familyImage = familyImage?.imageWithSize(scaledToSize: CGSize(width: 32, height: 32))
        let addFamily = UIAlertAction(title: "가족", style: .default, handler: {[self] _ in
            scheduleImage.image = UIImage(named: "family_addDate")
            self.category = "가족"
        })
        addFamily.setValue(familyImage?.withRenderingMode(.alwaysOriginal), forKey: "image")
        addFamily.setValue(UIColor.black, forKey: "titleTextColor")
        alert.addAction(addFamily)
        
        var personalImage = UIImage(named: "person_addDate")
        personalImage = personalImage?.imageWithSize(scaledToSize: CGSize(width: 32, height: 32))
        let addPersonal = UIAlertAction(title: "개인", style: .default, handler: {[self] _ in
            scheduleImage.image = UIImage(named: "person_addDate")
            self.category = "개인"
        })
        addPersonal.setValue(personalImage?.withRenderingMode(.alwaysOriginal), forKey: "image")
        addPersonal.setValue(UIColor.black, forKey: "titleTextColor")
        alert.addAction(addPersonal)
        
        var normalImage = UIImage(named: "normal_addDate")
        normalImage = normalImage?.imageWithSize(scaledToSize: CGSize(width: 32, height: 32))
        let addNormal = UIAlertAction(title: "일반", style: .default, handler: {[self] _ in
            scheduleImage.image = UIImage(named: "normal_addDate")
            self.category = "일반"
        })
        addNormal.setValue(normalImage?.withRenderingMode(.alwaysOriginal), forKey: "image")
        addNormal.setValue(UIColor.black, forKey: "titleTextColor")
        alert.addAction(addNormal)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        cancel.setValue(UIColor.FailyColor.coral, forKey: "titleTextColor")
        alert.addAction(cancel)
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func repeatButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "반복", message: "반복 주기를 선택 해주세요", preferredStyle: .actionSheet)
        
        let none = UIAlertAction(title: "안함", style: .default, handler: {[self] _ in
            repeatLabel.text = "안함"
        })
        none.setValue(UIColor.black, forKey: "titleTextColor")
        alert.addAction(none)
        
        let week = UIAlertAction(title: "매주", style: .default, handler: {[self] _ in
            repeatLabel.text = "매주"
        })
        week.setValue(UIColor.black, forKey: "titleTextColor")
        alert.addAction(week)
        
        let month = UIAlertAction(title: "매월", style: .default, handler: {[self] _ in
            repeatLabel.text = "매월"
        })
        month.setValue(UIColor.black, forKey: "titleTextColor")
        alert.addAction(month)
        
        let year = UIAlertAction(title: "매년", style: .default, handler: {[self] _ in
            repeatLabel.text = "매년"
        })
        year.setValue(UIColor.black, forKey: "titleTextColor")
        alert.addAction(year)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        cancel.setValue(UIColor.FailyColor.coral, forKey: "titleTextColor")
        alert.addAction(cancel)
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
        
        if self.category == "" {
            self.presentAlert(title: "카테고리를 선택해 주세요.")
        } else {
            
            guard let title = titleTextField.text?.trim, title.isExists else {
                self.presentAlert(title: "제목을 입력 해주세요.")
                return
            }
            
            guard let location = locationTextField.text?.trim, location.isExists else {
                self.presentAlert(title: "위치를 입력 해수제요.")
                return
            }
                    
            guard let memo = memoTextView.text?.trim, memo.isExists else {
                self.presentAlert(title: "메모를 입력 해주세요.")
                return
            }
            
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd-HH:mm"
            let startDate = dateFormatter.string(from: startDatePicker.date)
            let endDate = dateFormatter.string(from: endDatePicker.date)
            
            
                    
            
            let param = AddScheduleRequest(
                calendar_date: "2021-11-01",
                calendar_category: self.category,
                calendar_name: title,
                calendar_place: location,
                calendar_memo: memo,
                calendar_start_time: startDate,
                calendar_end_time: endDate
            )
            viewModel.postAddSchedule(param)
        }
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

extension AddDateViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        nil
    }
    
    var longFormHeight: PanModalHeight {
        return .maxHeight
    }

    var shortFormHeight: PanModalHeight {
        return longFormHeight
    }
    
    var cornerRadius: CGFloat {
        return 20.0
    }
}


extension AddDateViewController {
    func viewModelMethod() {
        viewModel.successAddSchedule = {
            let alert = UIAlertController(title: "저장되었습니다.", message: "", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "확인", style: .default, handler: {[self] _ in
                delegate?.reloadCalendar()
                dismiss(animated: true, completion: nil)
            })
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
