//
//  AgreeAuthorityViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/14.
//

import UIKit
import AVFoundation
import Photos

class AgreeAuthorityViewController: UIViewController {
    
    
    @IBOutlet weak var agreeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    func configUI() {
        self.navigationItem.backButtonTitle = ""
        self.title = "이메일로 가입하기"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
    }
    
    @IBAction func agreeButtonAction(_ sender: Any) {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { didAllow, error in
            if didAllow == true {
                print("알림 권한을 허용했습니다.")
            } else {
                print("알림 권한을 거부했습니다.")
            }
            
            UserDefaults.standard.set(true, forKey: UserDefaultKey.alertState)

            DispatchQueue.main.async {
                let storyBoard = UIStoryboard(name: "Tutorial", bundle: nil)
                let homeNav = storyBoard.instantiateViewController(identifier: "TutorialNav")
                self.changeRootViewController(homeNav)
            }
        })
    }
}
