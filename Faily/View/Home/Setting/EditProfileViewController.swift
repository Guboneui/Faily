//
//  EditProfileViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/10/05.
//

import UIKit

class EditProfileViewController: UIViewController {

    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var resignLabel: UILabel!
    
    override func loadView() {
        super.loadView()
        
        configUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func configUI() {
        print(profileImage.frame.height)
        print(profileImage.frame.width)
        profileImage.layoutIfNeeded()
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.clipsToBounds = true
        
        
        let labelString = "회원탈퇴"
        let textColor = UIColor.black
        let underLineColor = UIColor.black
        let underLineStyle = NSUnderlineStyle.single.rawValue

        let labelAtributes:[NSAttributedString.Key : Any]  = [
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.underlineStyle: underLineStyle,
            NSAttributedString.Key.underlineColor: underLineColor
        ]
        let underlineAttributedString = NSAttributedString(string: labelString, attributes: labelAtributes)

        let resignTapGesture = UITapGestureRecognizer(target: self, action: #selector(resignLabelAction))
        resignLabel.isUserInteractionEnabled = true
        resignLabel.addGestureRecognizer(resignTapGesture)
        resignLabel.attributedText = underlineAttributedString
        
    }
    
    @objc func resignLabelAction(sender: UITapGestureRecognizer) {
        self.presentAlert(title: "탈퇴하시겠어요?")
    }
    

    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
