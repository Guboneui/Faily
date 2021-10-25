//
//  QAViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/28.
//

import UIKit



protocol ReloadQuestionCollectionViewDelegate: AnyObject {
    func reloadCollectionView()
}



class QAViewController: UIViewController{

    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerTextView: UITextView!
    
    var question = ""
    var getQuestionIndex: Int = 0
    
    lazy var viewModel: SendAnswerViewModel = SendAnswerViewModel()
    
    weak var delegate: ReloadQuestionCollectionViewDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        self.questionLabel.text = question
        viewModel.qaView = self
        viewModelMethod()
        
        
    }
    
    func configUI() {
        answerTextView.delegate = self
        answerTextView.text = "답변을 작성해주세요."
        answerTextView.textColor = UIColor.FailyColor.placeholder_gray
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(endTyping))
        
        let items = [flexSpace, doneButton]
        toolbar.items = items
        
        answerTextView.inputAccessoryView = toolbar
    }
    
    @objc func endTyping() {
        answerTextView.endEditing(true)
    }
    
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "취소", message: "해당 내용은 저장되지 않습니다.", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "취소", style: .default, handler: nil)
        let okButton = UIAlertAction(title: "확인", style: .default, handler: {[self] _ in
            dismiss(animated: true, completion: nil)
        })
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        
        guard let answer = answerTextView.text?.trim, answer.isExists else {
            self.presentAlert(title: "답변을 입력 해주세요")
            return
        }
        
        let param = SendAnswerRequest(answer: answer, question_index: self.getQuestionIndex)
        print(param)
        viewModel.postSendAnswer(param)
                
                

    }
    
    
}

extension QAViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {

        textViewSetupView()
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if answerTextView.text == "" {
            textViewSetupView()
        }
    }



    func textViewSetupView() {
        if answerTextView.text == "답변을 작성해주세요." {
            answerTextView.text = ""
            answerTextView.textColor = UIColor.black
        } else if answerTextView.text == ""{
            answerTextView.text = "답변을 작성해주세요."
            answerTextView.textColor = UIColor.FailyColor.placeholder_gray
        }
    }
    

}


extension QAViewController {
    func viewModelMethod() {
        viewModel.dismissView = {
            let alert = UIAlertController(title: "답변", message: "답변이 작성되었습니다..", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "확인", style: .default, handler: {[self] _ in
                delegate?.reloadCollectionView()
                dismiss(animated: true, completion: nil)
            })
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
