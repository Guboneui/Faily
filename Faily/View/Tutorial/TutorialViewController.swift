//
//  TutorialViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/16.
//

import UIKit

class TutorialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    func existGroupCode() {
        if UserDefaults.standard.string(forKey: UserDefaultKey.groupCode) != nil {
            let alert = UIAlertController(title: "알림", message: "이미 참가된 그룹 코드가 존재합니다.\n메인 화면으로 이동합니다.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "확인", style: .default, handler: {_ in
                let storyBoard = UIStoryboard(name: "Home", bundle: nil)
                let homeNAV = storyBoard.instantiateViewController(identifier: "HomeNav")
                self.changeRootViewController(homeNAV)
            })
            alert.addAction(okButton)
            self.present(alert, animated: true)
        }
    }
    
    func configUI() {
        self.navigationItem.backButtonTitle = ""
        self.title = "시작하기"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
    }
    
    @IBAction func goFounderVCButtonAction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Tutorial", bundle: nil)
        let founderVC = storyBoard.instantiateViewController(withIdentifier: "FounderViewController")
        self.navigationController?.pushViewController(founderVC, animated: true)
    }
    
    @IBAction func goParticipantVCButtonAction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Tutorial", bundle: nil)
        let participantVC = storyBoard.instantiateViewController(withIdentifier: "ParticipantViewController")
        self.navigationController?.pushViewController(participantVC, animated: true)
    }
    
    
}
