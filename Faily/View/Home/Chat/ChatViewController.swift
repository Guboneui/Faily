//
//  ChatViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/17.
//

import UIKit
import CoreMIDI

class ChatViewController: UIViewController {

    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var bottomBaseView: UIView!
    @IBOutlet weak var bottomBaseViewHeight: NSLayoutConstraint!
    @IBOutlet weak var typingBaseView: UIView!
    @IBOutlet weak var messageTextView: UITextView!
    
    var menuState = false
    
    let stackView = UIStackView()
    let emoticonStackView = UIStackView()
    let galleryStackView = UIStackView()
    let cameraStackView = UIStackView()
    let scheduleStackView = UIStackView()
    
    
    override func loadView() {
        super.loadView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        
        let emoticonImage = UIImageView()
        emoticonImage.image = UIImage(named: "emoticon_chat")
        let emoticonLabel = UILabel(frame: .zero)
        emoticonLabel.textAlignment = .center
        emoticonLabel.font = .boldSystemFont(ofSize: 12)
        emoticonLabel.textColor = UIColor(named: "grayscale2")
        emoticonLabel.text = "이모티콘"
        
        
        emoticonStackView.axis = .vertical
        emoticonStackView.alignment = .center
        emoticonStackView.distribution = .equalSpacing
        emoticonStackView.spacing = 3
        emoticonStackView.addArrangedSubview(emoticonImage)
        emoticonStackView.addArrangedSubview(emoticonLabel)
        emoticonStackView.translatesAutoresizingMaskIntoConstraints = false
        
       
        
        let galleryImage = UIImageView()
        galleryImage.image = UIImage(named: "gallery_chat")
        let galleryLabel = UILabel(frame: .zero)
        galleryLabel.textAlignment = .center
        galleryLabel.font = .boldSystemFont(ofSize: 12)
        galleryLabel.textColor = UIColor(named: "grayscale2")
        galleryLabel.text = "갤러리"
        
        
        galleryStackView.axis = .vertical
        galleryStackView.alignment = .center
        galleryStackView.distribution = .equalSpacing
        galleryStackView.spacing = 3
        galleryStackView.addArrangedSubview(galleryImage)
        galleryStackView.addArrangedSubview(galleryLabel)
        galleryStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let cameraImage = UIImageView()
        cameraImage.image = UIImage(named: "camera_chat")
        let cameraLabel = UILabel(frame: .zero)
        cameraLabel.textAlignment = .center
        cameraLabel.font = .boldSystemFont(ofSize: 12)
        cameraLabel.textColor = UIColor(named: "grayscale2")
        cameraLabel.text = "카메라"
        
        
        cameraStackView.axis = .vertical
        cameraStackView.alignment = .center
        cameraStackView.distribution = .equalSpacing
        cameraStackView.spacing = 3
        cameraStackView.addArrangedSubview(cameraImage)
        cameraStackView.addArrangedSubview(cameraLabel)
        cameraStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
        let scheduleImage = UIImageView()
        scheduleImage.image = UIImage(named: "schedule_chat")
        let scheduleLabel = UILabel(frame: .zero)
        scheduleLabel.textAlignment = .center
        scheduleLabel.font = .boldSystemFont(ofSize: 12)
        scheduleLabel.textColor = UIColor(named: "grayscale2")
        scheduleLabel.text = "일정"
        
        
        scheduleStackView.axis = .vertical
        scheduleStackView.alignment = .center
        scheduleStackView.distribution = .equalSpacing
        scheduleStackView.spacing = 3
        scheduleStackView.addArrangedSubview(scheduleImage)
        scheduleStackView.addArrangedSubview(scheduleLabel)
        scheduleStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        stackView.addArrangedSubview(emoticonStackView)
        stackView.addArrangedSubview(galleryStackView)
        stackView.addArrangedSubview(cameraStackView)
        stackView.addArrangedSubview(scheduleStackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.bottomBaseView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            emoticonImage.heightAnchor.constraint(equalToConstant: 24),
            emoticonImage.widthAnchor.constraint(equalToConstant: 24),
     
            galleryImage.heightAnchor.constraint(equalToConstant: 24),
            galleryImage.widthAnchor.constraint(equalToConstant: 24),
            
            cameraImage.heightAnchor.constraint(equalToConstant: 24),
            cameraImage.widthAnchor.constraint(equalToConstant: 24),
           
            scheduleImage.heightAnchor.constraint(equalToConstant: 24),
            scheduleImage.widthAnchor.constraint(equalToConstant: 24),
            
            stackView.topAnchor.constraint(equalTo: self.typingBaseView.bottomAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: self.bottomBaseView.leadingAnchor, constant: 60),
            stackView.trailingAnchor.constraint(equalTo: self.bottomBaseView.trailingAnchor, constant: -60),
            //stackView.centerYAnchor.constraint(equalTo: self.bottomBaseView.centerYAnchor),
            
            
        ])
        typingBaseView.layer.cornerRadius = 17
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stackView.isHidden = true
        
        
        let galleryStackViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(galleryStackViewActoin))
        galleryStackView.isUserInteractionEnabled = true
        galleryStackView.addGestureRecognizer(galleryStackViewTapGesture)
        
        let cameraStackViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(cameraStackViewAction))
        cameraStackView.isUserInteractionEnabled = true
        cameraStackView.addGestureRecognizer(cameraStackViewTapGesture)
        
        let scheduleStackViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(scheduleStackViewAction))
        scheduleStackView.isUserInteractionEnabled = true
        scheduleStackView.addGestureRecognizer(scheduleStackViewTapGesture)
        
        
    }
    
    @objc func galleryStackViewActoin(_ sender: UITapGestureRecognizer) {
        print("gallery")
    }
    
    @objc func cameraStackViewAction(_ sender: UITapGestureRecognizer) {
        print("camera")
    }
    
    @objc func scheduleStackViewAction(_ sender: UITapGestureRecognizer) {
        print("schedule")
    }
    
    
    @IBAction func dismissButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func menuButtonAction(_ sender: Any) {
        self.menuState.toggle()
        if menuState == true {
            bottomBaseView.layoutIfNeeded()
            menuButton.setImage(UIImage(named: "closeMark"), for: .normal)
            messageTextView.endEditing(true)
            UIView.animate(withDuration: 0, animations: {() -> Void in
                self.bottomBaseViewHeight.constant = 125
            })
            stackView.isHidden = false
        } else {
            bottomBaseView.layoutIfNeeded()
            menuButton.setImage(UIImage(named: "add_chat"), for: .normal)
            messageTextView.endEditing(true)
            UIView.animate(withDuration: 0, animations: {() -> Void in
                self.bottomBaseViewHeight.constant = 64
            })
            stackView.isHidden = true
        }
        
    }
    
}
