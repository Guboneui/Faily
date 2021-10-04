//
//  SettingFamilyCodeViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/10/05.
//

import UIKit

class SettingFamilyCodeViewController: UIViewController {

    @IBOutlet var baseView: UIView!
    @IBOutlet weak var codeView: UIView!
    @IBOutlet weak var inviteCodeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGesture()
       
    }
    
    func addGesture() {
        let dismissBaseViewGesture = UITapGestureRecognizer(target: self, action: #selector(dissmissView))
        baseView.isUserInteractionEnabled = true
        baseView.addGestureRecognizer(dismissBaseViewGesture)
    }
    
    @objc func dissmissView(sender: UITapGestureRecognizer) {
        self.dismiss(animated: false, completion: nil)
    }
    

    @IBAction func shareCodeButtonAction(_ sender: Any) {
        var objectsToShare = [String]()
        if let text = inviteCodeLabel.text {
            objectsToShare.append("🥳Faily 가족 인증코드를 보내드려요\n\(text)")
            print("공유할 텍스트는 [\(text)]입니다.")
        }
        
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func copyCodeButtonAction(_ sender: Any) {
        print("초대코드가 복사되었습니다.")
        let alert = UIAlertController(title: "초대코드가 복사되었습니다.", message: "", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        UIPasteboard.general.string = inviteCodeLabel.text
    }
}
