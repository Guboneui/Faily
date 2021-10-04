//
//  FounderViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/16.
//

import UIKit

class FounderViewController: UIViewController {

    
    @IBOutlet weak var inviteCodeLabel: UILabel!
    var getInviteCode: String = "코드 발급 중"
    
    lazy var viewModel: InviteViewModel = InviteViewModel()
    override func loadView() {
        super.loadView()
        inviteCodeLabel.text = getInviteCode
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        viewModel.inviteView = self
        viewModelMethod()
        
        if UserDefaults.standard.bool(forKey: UserDefaultKey.createdGroupCode) == true {
            print("이미 코드가 발급되었습니다.")
            inviteCodeLabel.text = UserDefaults.standard.string(forKey: UserDefaultKey.groupCode)
        } else {
            print("발급된 코드가 없어서 채팅방 코드가 발급되었습니다.")
            let param = InviteRequest()
            viewModel.postGroupCode(param)
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    func configUI() {
        self.navigationItem.backButtonTitle = ""
        self.title = "시작하기"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
    }
    
    @IBAction func shareInviteCodeButtonAction(_ sender: Any) {
        var objectsToShare = [String]()
        if let text = inviteCodeLabel.text {
            objectsToShare.append("🥳Faily 가족 인증코드를 보내드려요\n\(text)")
            print("공유할 텍스트는 [\(text)]입니다.")
        }
        
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true, completion: nil)
    }
    
    
    @IBAction func copyInviteCodeButtonAction(_ sender: Any) {
        print("초대코드가 복사되었습니다.")
        let alert = UIAlertController(title: "초대코드가 복사되었습니다.", message: "", preferredStyle: .alert)
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


extension FounderViewController {
    func viewModelMethod() {
        viewModel.showCodeLabel = {[self] code in
            inviteCodeLabel.text = code
        }
        
        
        viewModel.showAlert = { [self] message in
            let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
    }
}
