//
//  DeviceSettingViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/10/06.
//

import UIKit


struct SettingTitle {
    var title: String
}

struct AlertSetting {
    var mainTitle: String
    var subTitle: String
    var alertState: Bool
}

struct PolicySetting {
    var title: String
}



class DeviceSettingViewController: UIViewController {
    
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var deviceSettingTableView: UITableView!
    
    
    var settingTitle = [
        SettingTitle(title: "알림"),
        SettingTitle(title: "약관 및 정책"),
        SettingTitle(title: "앱 소개")
    ]
    
    var alertSetting = [
        AlertSetting(mainTitle: "채팅 알림", subTitle: "채팅 메시지 알림", alertState: true),
        AlertSetting(mainTitle: "활동 알림", subTitle: "질문, 일정 등 알림", alertState: true),
        AlertSetting(mainTitle: "기타 알림", subTitle: "공지사항 등 알림", alertState: false)
    ]
    
    var policySetting = [
        PolicySetting(title: "서비스 이용 약관"),
        PolicySetting(title: "개인정보 처리 방침"),
        PolicySetting(title: "오픈소스 라이선스")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        
    }
    func setTableView() {
        deviceSettingTableView.delegate = self
        deviceSettingTableView.dataSource = self
        deviceSettingTableView.separatorStyle = .none
        
        deviceSettingTableView.register(UINib(nibName: "TitleSettingTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleSettingTableViewCell")
        deviceSettingTableView.register(UINib(nibName: "AlertSettingTableViewCell", bundle: nil), forCellReuseIdentifier: "AlertSettingTableViewCell")
        deviceSettingTableView.register(UINib(nibName: "PolicySettingTableViewCell", bundle: nil), forCellReuseIdentifier: "PolicySettingTableViewCell")
        deviceSettingTableView.register(UINib(nibName: "SettingGuideLineTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingGuideLineTableViewCell")
    }
    
    @IBAction func backbuttonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension DeviceSettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 || indexPath.row == 5 || indexPath.row == 10 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleSettingTableViewCell", for: indexPath) as! TitleSettingTableViewCell
            
            if indexPath.row == 0 {
                cell.mainTitleLabel.text = self.settingTitle[0].title
            } else if indexPath.row == 5 {
                cell.mainTitleLabel.text = self.settingTitle[1].title
            } else if indexPath.row == 10 {
                cell.mainTitleLabel.text = self.settingTitle[2].title
            }
            
            cell.selectionStyle = .none
            return cell
        } else if indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlertSettingTableViewCell", for: indexPath) as! AlertSettingTableViewCell
            
            if indexPath.row == 1 {
                cell.mainTitleLabel.text = self.alertSetting[0].mainTitle
                cell.subTitleLabel.text = self.alertSetting[0].subTitle
                cell.alertStateSwitch.isOn = self.alertSetting[0].alertState
            } else if indexPath.row == 2 {
                cell.mainTitleLabel.text = self.alertSetting[1].mainTitle
                cell.subTitleLabel.text = self.alertSetting[1].subTitle
                cell.alertStateSwitch.isOn = self.alertSetting[1].alertState
            } else if indexPath.row == 3 {
                cell.mainTitleLabel.text = self.alertSetting[2].mainTitle
                cell.subTitleLabel.text = self.alertSetting[2].subTitle
                cell.alertStateSwitch.isOn = self.alertSetting[2].alertState
            }
            
            cell.selectionStyle = .none
            return cell
        } else if indexPath.row == 6 || indexPath.row == 7 || indexPath.row == 8 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PolicySettingTableViewCell", for: indexPath) as! PolicySettingTableViewCell
            
            
            if indexPath.row == 6 {
                cell.policyTitleLabel.text = self.policySetting[0].title
            } else if indexPath.row == 7 {
                cell.policyTitleLabel.text = self.policySetting[1].title
            } else if indexPath.row == 8 {
                cell.policyTitleLabel.text = self.policySetting[2].title
            }
            
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingGuideLineTableViewCell", for: indexPath) as! SettingGuideLineTableViewCell
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 6 {
            self.presentAlert(title: "서비스 이용 약관")
        } else if indexPath.row == 7 {
            self.presentAlert(title: "개인정보 처리 방침")
        } else if indexPath.row == 8 {
            self.presentAlert(title: "오픈소스 라이선스")
        } else if indexPath.row == 10 {
            self.presentAlert(title: "앱 소개")
        }
        
        
    }
    
    
}
