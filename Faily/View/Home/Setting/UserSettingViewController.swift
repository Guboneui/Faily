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
        stackViewAction()
    }
    
    func configUI() {
        self.profileBaseView.layer.cornerRadius = 20
        self.makeShadow(profileBaseView)
        self.profileBGView.layer.cornerRadius = 20
        
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height / 2

        
    }
    
    func stackViewAction() {
        let presentStackViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(presentStackViewAction))
        presentStackView.isUserInteractionEnabled = true
        presentStackView.addGestureRecognizer(presentStackViewTapGesture)
        
        let emoticonStackViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(emoticonStackViewAction))
        emoticonStackView.isUserInteractionEnabled = true
        emoticonStackView.addGestureRecognizer(emoticonStackViewTapGesture)
        
        let pointStackViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(pointStackViewAction))
        pointStackView.isUserInteractionEnabled = true
        pointStackView.addGestureRecognizer(pointStackViewTapGesture)
    }
    
    @objc func presentStackViewAction(sender: UITapGestureRecognizer) {
        print("선물")
    }
    
    @objc func emoticonStackViewAction(sender: UITapGestureRecognizer) {
        print("이모티콘")
    }
    
    @objc func pointStackViewAction(sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "준비중인 서비스 입니다.", message: "", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func goEditProfileButtonAction(_ sender: Any) {
        print("프로필 수정")
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let editProfileVC = storyBoard.instantiateViewController(withIdentifier: "EditProfileViewController")
        
        self.navigationController?.pushViewController(editProfileVC, animated: true)
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
            let storyBoard = UIStoryboard(name: "Home", bundle: nil)
            let familyCodeVC = storyBoard.instantiateViewController(withIdentifier: "SettingFamilyCodeViewController")
            familyCodeVC.modalPresentationStyle = .overCurrentContext
            self.present(familyCodeVC, animated: false, completion: nil)
        } else if indexPath.row == 1 {
            print("공지사항")
        } else if indexPath.row == 2 {
            print("앱 설정")
        }
    }
    
}
