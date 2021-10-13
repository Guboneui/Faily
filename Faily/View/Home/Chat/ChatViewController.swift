//
//  ChatViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/17.
//

import UIKit
import CoreMIDI
import IQKeyboardManager
import Photos
import AVFoundation
import AVKit
import BSImagePicker

struct ChatMessage {
    let userName: String
    let message: String
    let profileImage: String
    let sendTime: String
}



class ChatViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var bottomBaseView: UIView!
    @IBOutlet weak var bottomBaseViewHeight: NSLayoutConstraint!
    @IBOutlet weak var typingBaseView: UIView!
    @IBOutlet weak var messageTextView: UITextView!
    
    @IBOutlet weak var chatTableView: UITableView!
    
    var menuState = false
    
    let stackView = UIStackView()
    let emoticonStackView = UIStackView()
    let galleryStackView = UIStackView()
    let cameraStackView = UIStackView()
    let scheduleStackView = UIStackView()
    
    var selectedAssets = [PHAsset]()
    
    var message: [ChatMessage] = [
        ChatMessage(userName: "보니", message: "안녕하세요", profileImage: "boni", sendTime: "오후 11시 20분"),
        ChatMessage(userName: "수빈", message: "안녕하세요~~", profileImage: "subin", sendTime: "오후 11시 22분"),
        ChatMessage(userName: "수빈", message: "저는 정수빈입니다.", profileImage: "subin", sendTime: "오후 11시 23분"),
        ChatMessage(userName: "승빈", message: "처음 뵙겠습니댱", profileImage: "sb", sendTime: "오후 11시 25분"),
        ChatMessage(userName: "보니", message: "안녕하세요~~~", profileImage: "boni", sendTime: "오후 11시 25분"),
        ChatMessage(userName: "나연", message: "안녕하세요", profileImage: "nayoun", sendTime: "오후 11시 26분"),
        ChatMessage(userName: "나연", message: "이제 막 참가했어요", profileImage: "nayoun", sendTime: "오후 11시 26분"),
        ChatMessage(userName: "수빈", message: "안녕하세요!!", profileImage: "subin", sendTime: "오후 11시 26분"),
        ChatMessage(userName: "승빈", message: "안녕하세요!!!!", profileImage: "sb", sendTime: "오후 11시 27분"),
        ChatMessage(userName: "승빈", message: "저희 잘 지내봐용", profileImage: "sb", sendTime: "오후 11시 28분"),
        ChatMessage(userName: "승빈", message: "화이팅팅팅", profileImage: "sb", sendTime: "오후 11시 28분"),
        ChatMessage(userName: "보니", message: "~~~~~", profileImage: "boni", sendTime: "오후 11시 30분"),
        
    ]
    
    
    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
    @IBOutlet weak var inputViewBottomMargin: NSLayoutConstraint!
    
    @IBOutlet weak var tableViewBottomMargin: NSLayoutConstraint!
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    
    
    var isFistLayoutSubviews = true
    var oldTableViewBottomInset: CGFloat = 0
    
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
        IQKeyboardManager.shared().isEnabled = false
        
        let galleryStackViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(galleryStackViewActoin))
        galleryStackView.isUserInteractionEnabled = true
        galleryStackView.addGestureRecognizer(galleryStackViewTapGesture)
        
        let cameraStackViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(cameraStackViewAction))
        cameraStackView.isUserInteractionEnabled = true
        cameraStackView.addGestureRecognizer(cameraStackViewTapGesture)
        
        let scheduleStackViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(scheduleStackViewAction))
        scheduleStackView.isUserInteractionEnabled = true
        scheduleStackView.addGestureRecognizer(scheduleStackViewTapGesture)
        
        
        
        
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.separatorStyle = .none
        chatTableView.register(UINib(nibName: "MyMessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MyMessageTableViewCell")
        chatTableView.register(UINib(nibName: "FamilyMessageTableViewCell", bundle: nil), forCellReuseIdentifier: "FamilyMessageTableViewCell")
        
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: {(completed) in
            let indexPath = IndexPath(row: self.message.count - 1, section: 0)
            self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        })
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShowNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHideNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    
    @objc func handleKeyboardShowNotification(_ sender: Notification) {
        
        let userInfo:NSDictionary = sender.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        print(keyboardRectangle)
        
        if menuState == false {
            bottomMargin.constant =  keyboardRectangle.height - 22
        } else {
            bottomMargin.constant =  keyboardRectangle.height - 83
        }
        
        
        
       
        

        
    }
    
    @objc func handleKeyboardHideNotification(_ sender: Notification) {
        
        let userInfo:NSDictionary = sender.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        print(keyboardRectangle)
        
        
        bottomMargin.constant = 0

        
    }
    
    
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        IQKeyboardManager.shared().isEnabled = true
    }
    
    @objc func galleryStackViewActoin(_ sender: UITapGestureRecognizer) {
        let imagePicker = ImagePickerController()
        imagePicker.settings.selection.max = 5
        imagePicker.settings.theme.selectionStyle = .checked
        
        imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
        imagePicker.settings.selection.unselectOnReachingMax = false
        imagePicker.settings.theme.selectionFillColor = .clear
        imagePicker.settings.theme.selectionShadowColor = .clear
        imagePicker.settings.theme.selectionStrokeColor = .clear
        
        imagePicker.cancelButton.setBackgroundImage(UIImage(named: "closeMark"), for: .normal, barMetrics: .default)
        imagePicker.cancelButton.tintColor = UIColor.black
        imagePicker.albumButton.tintColor = UIColor.black
        
        let start = Date()
        
        //imagePicker.modalPresentationStyle = .currentContext
        self.presentImagePicker(imagePicker, select: { (asset) in
            print("Selected: \(asset)")
            
        }, deselect: { (asset) in
            print("Deselected: \(asset)")
        }, cancel: { (assets) in
            print("Canceled with selections: \(assets)")
        }, finish: { (assets) in
            print("Finished with selections: \(assets)")
        }, completion: {
            let finish = Date()
            print(finish.timeIntervalSince(start))
        })
        let options = imagePicker.settings.fetch.album.options
        imagePicker.settings.fetch.album.fetchResults = [
            PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: options),
            PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: options),
        ]
        
        
        print("gallery")
    }
    
    @objc func cameraStackViewAction(_ sender: UITapGestureRecognizer) {
        print("camera")
    }
    
    @objc func scheduleStackViewAction(_ sender: UITapGestureRecognizer) {
        print("schedule")
    }
    
    
    @IBAction func dismissButtonAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
        
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
    
    
    @IBAction func sendButtonAction(_ sender: Any) {
        
        if messageTextView.text != nil || messageTextView.text != "" {
            message.append(ChatMessage(userName: "보니", message: self.messageTextView.text, profileImage: "boni", sendTime: "오후 11시 30분"))
            self.chatTableView.reloadData()
            self.messageTextView.text = nil
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: {(completed) in
                let indexPath = IndexPath(row: self.message.count - 1, section: 0)
                self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
            })
        }
        
        
        
    }
    
}


extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.message.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let chatMessage = message[indexPath.row]
        
        if chatMessage.userName == "보니"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyMessageTableViewCell", for: indexPath) as! MyMessageTableViewCell
            cell.myMessageLabel.text = chatMessage.message
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyMessageTableViewCell", for: indexPath) as! FamilyMessageTableViewCell
            cell.nameLabel.text = chatMessage.userName
            cell.messageLabel.text = chatMessage.message
            cell.profileImage.image = UIImage(named: chatMessage.profileImage)
            cell.timeLabel.text = chatMessage.sendTime
            return cell
        }
        
        
        
    }
    
    
}
