//
//  UserSettingViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/16.
//

import UIKit

struct Setting {
    var image: String
    var name: String
    var isHidden: Bool
}

class UserSettingViewController: UIViewController {
    
    
    @IBOutlet weak var profileBaseView: UIView!
    @IBOutlet weak var profileBGView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var goEditProfileButton: UIButton!
    @IBOutlet weak var presentStackView: UIStackView!
    @IBOutlet weak var emoticonStackView: UIStackView!
    @IBOutlet weak var pointStackView: UIStackView!
    
    @IBOutlet weak var settingTableView: UITableView!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    var settings = [
        Setting(image: "check_family_code", name: "가족 초대코드 확인", isHidden: true),
        Setting(image: "notice_mic", name: "공지사항", isHidden: false),
        Setting(image: "device_setting", name: "앱 설정", isHidden: false)
    ]
    
    override func loadView() {
        super.loadView()
        configUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        // Do any additional setup after loading the view.
    }
    
    func configUI() {
        self.profileBaseView.layer.cornerRadius = 20
        self.makeShadow(profileBaseView)
        self.profileBGView.layer.cornerRadius = 20
        
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height / 2

        
    }
    
    func stackViewAction() {
        
    }
    
    
    func setTableView() {
        self.settingTableView.delegate = self
        self.settingTableView.dataSource = self
        self.settingTableView.register(UINib(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingTableViewCell")
        self.settingTableView.rowHeight = UITableView.automaticDimension
        self.settingTableView.estimatedRowHeight = 27
        self.settingTableView.separatorStyle = .none
        
    }
}

extension UserSettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
        let settingData = settings[indexPath.row]
        
        cell.settingImage.image = UIImage(named: settingData.image)
        cell.settingTitleLabel.text = settingData.name
        cell.nextButton.isHidden = settingData.isHidden
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            print("가족 초대코드 확인")
        } else if indexPath.row == 1 {
            print("공지사항")
        } else if indexPath.row == 2 {
            print("앱 설정")
        }
    }
    
}
