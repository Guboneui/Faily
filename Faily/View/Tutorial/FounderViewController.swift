//
//  FounderViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/16.
//

import UIKit

class FounderViewController: UIViewController {

    
    @IBOutlet weak var inviteCodeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        // Do any additional setup after loading the view.
    }
    func configUI() {
        self.navigationItem.backButtonTitle = ""
        self.title = "시작하기"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
    }
    
    @IBAction func copyInviteCodeButtonAction(_ sender: Any) {
        print("초대코드가 복사되었습니다.")
        let alert = UIAlertController(title: "초대코드를 가족에게 공유 해보세요.", message: "", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        UIPasteboard.general.string = inviteCodeLabel.text
    }
    

    @IBAction func goMainHomeButtonAction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let homeNAV = storyBoard.instantiateViewController(identifier: "HomeNav")
        self.changeRootViewController(homeNAV)
    }
    

}
