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
import PanModal
import RxSwift

struct ChatMessage {
    let userName: String
    let userProfile: String
    let isPhoto: Bool
    let isSchedule: Bool
    let message: String
    let sendTime: String
    let emoticon: UIImage?
    let photo: UIImage?
    let scheduleDate: String?
    let scheduleTitle: String?
}



class ChatViewController: UIViewController {
    
    @IBOutlet weak var scheduleViewBottomMargin: NSLayoutConstraint!
    @IBOutlet weak var titleBottomMargin: NSLayoutConstraint!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var bottomBaseView: UIView!
    @IBOutlet weak var bottomBaseViewHeight: NSLayoutConstraint!
    @IBOutlet weak var typingBaseView: UIView!
    @IBOutlet weak var messageTextView: UITextView!
    
    @IBOutlet weak var chatTableView: UITableView!
    
    @IBOutlet weak var userEmoticonBaseView: UIView!
    
    @IBOutlet weak var userEmoticonCollectionView: UICollectionView!
    let sectionInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 0)
    var selectedIndexPath: IndexPath = [] {
        didSet {
            userEmoticonCollectionView.reloadData()
        }
    }
    
    var menuState = false
    var emoticonState = false
    var isChat = true
    
    @IBOutlet weak var scheduleBaseView: UIView!
    @IBOutlet weak var selectScheduleCategory: UIImageView!
    @IBOutlet weak var showMoreScheduleOption: UILabel!
    @IBOutlet weak var schduleAllDaySwitch: UISwitch!
    
    
    var selectedEmoticon: UIImage? = nil
    var userSelectedImages: [UIImage] = []
    
    
    let stackView = UIStackView()
    let emoticonStackView = UIStackView()
    let galleryStackView = UIStackView()
    let cameraStackView = UIStackView()
    let scheduleStackView = UIStackView()
    
    var selectedAssets = [PHAsset]()
    
    static var emoticonArray = [
        UIImage(named: "이모티콘1"),
        UIImage(named: "이모티콘2"),
        UIImage(named: "이모티콘3"),
        UIImage(named: "이모티콘4"),
        UIImage(named: "이모티콘5")
        
    ]
   
    
    lazy var viewModel: ChatViewModel = ChatViewModel()
    lazy var emoticonViewModel: GetAllEmoticonViewModel = GetAllEmoticonViewModel()
    
    static var message: [ChatMessage] = [
        ChatMessage(userName: "본의", userProfile: "본의_프로필", isPhoto: false, isSchedule: false, message: "우리 가족 단톡방을 생성했어요!!!!", sendTime: "오전 10시 23분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "수빈", userProfile: "수빈_프로필", isPhoto: false, isSchedule: false, message: "오오오오오오오 카톡보다 좋은거 같은데???", sendTime: "오전 10시 27분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "나연", userProfile: "나연_프로필", isPhoto: false, isSchedule: false, message: "나도 들어왔댱", sendTime: "오전 10시 28분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "수빈", userProfile: "수빈_프로필", isPhoto: false, isSchedule: false, message: "승빈이 언제 들어오는거야", sendTime: "오전 10시 28분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "승빈", userProfile: "승빈_프로필", isPhoto: false, isSchedule: false, message: "하하하하하하하하하하하하하", sendTime: "오전 11시 5분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "본의", userProfile: "본의_프로필", isPhoto: false, isSchedule: false, message: "ㅎㅇㅎㅇ", sendTime: "오전 11시 8분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "나연", userProfile: "나연_프로필", isPhoto: false, isSchedule: false, message: "왤케 늦게 들어옴", sendTime: "오전 11시 15분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "승빈", userProfile: "승빈_프로필", isPhoto: false, isSchedule: false, message: "호두 산책시키고 왔는데욤?", sendTime: "오전 11시 16분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "나연", userProfile: "나연_프로필", isPhoto: false, isSchedule: false, message: "암튼 젤 늦어", sendTime: "오전 11시 16분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "승빈", userProfile: "승빈_프로필", isPhoto: false, isSchedule: false, message: "내가 주인공이거든😎", sendTime: "오전 11시 16분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "본의", userProfile: "본의_프로필", isPhoto: false, isSchedule: false, message: ";;;;;;;;;;;;;;;;;;;;;;;;;", sendTime: "오전11시 18분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "승빈", userProfile: "승빈_프로필", isPhoto: false, isSchedule: false, message: "넝담~~", sendTime: "오전 11시 18분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "나연", userProfile: "나연_프로필", isPhoto: false, isSchedule: false, message: "오늘 날씨가 좋아용", sendTime: "오후 12시 2분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "나연", userProfile: "나연_프로필", isPhoto: true, isSchedule: false, message: "", sendTime: "오후 12시 03분", emoticon: nil, photo: UIImage(named: "chat_image3"), scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "본의", userProfile: "본의_프로필", isPhoto: false, isSchedule: false, message: "난 오늘 점심 차슈 덮밥 먹었어용~~", sendTime: "오후 12시 23분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "본의", userProfile: "본의_프로필", isPhoto: true, isSchedule: false, message: "", sendTime: "오후 12시 23분", emoticon: nil, photo: UIImage(named: "chat_image2"), scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "승빈", userProfile: "승빈_프로필", isPhoto: false, isSchedule: false, message: "그래서 우리 여행은 어딜로 언제 가는게 좋을까???", sendTime: "오후 5시 17분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "수빈", userProfile: "수빈_프로필", isPhoto: false, isSchedule: false, message: "나 바다 보고 싶은데", sendTime: "오후 5시 19분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "수빈", userProfile: "수빈_프로필", isPhoto: false, isSchedule: false, message: "겨울바다 보러가자", sendTime: "오후 5시 19분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "수빈", userProfile: "수빈_프로필", isPhoto: false, isSchedule: false, message: "아니면 캠핑장도 좋아", sendTime: "오후 5시 19분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "수빈", userProfile: "수빈_프로필", isPhoto: false, isSchedule: false, message: "요런곳", sendTime: "오후 5시 19분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "수빈", userProfile: "수빈_프로필", isPhoto: true, isSchedule: false, message: "", sendTime: "오후 5시 20분", emoticon: nil, photo: UIImage(named: "chat_image1"), scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "본의", userProfile: "본의_프로필", isPhoto: false, isSchedule: false, message: "오 좋아!!! 운전은 승빈이가 하면 되겠댜", sendTime: "오후 5시 23분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "승빈", userProfile: "승빈_프로필", isPhoto: false, isSchedule: false, message: "저요.......?", sendTime: "오후 5시 25분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "나연", userProfile: "나연_프로필", isPhoto: false, isSchedule: false, message: "승빈이 운전하면 진짜 꿀잠 계약", sendTime: "오후 5시 39분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "수빈", userProfile: "수빈_프로필", isPhoto: false, isSchedule: false, message: "원래 승빈이가 운전 담당이긴 하지", sendTime: "오후 5시 45분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "수빈", userProfile: "수빈_프로필", isPhoto: false, isSchedule: false, message: "못하겠으면 내가 하고~", sendTime: "오후 5시 50분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "나연", userProfile: "나연_프로필", isPhoto: false, isSchedule: false, message: "나 여행 안갈래.....", sendTime: "오후 5시 51분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "승빈", userProfile: "승빈_프로필", isPhoto: false, isSchedule: false, message: "키키키키키킼 난 좋아", sendTime: "오후 6시 23분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "본의", userProfile: "본의_프로필", isPhoto: false, isSchedule: false, message: "어우우ㅜ우우우우", sendTime: "오후 6시 25분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "수빈", userProfile: "수빈_프로필", isPhoto: false, isSchedule: false, message: "왜왜왜왜왜왜왜왜왜왱", sendTime: "오후 6시 26분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "승빈", userProfile: "승빈_프로필", isPhoto: false, isSchedule: false, message: "아닙니댜~~~", sendTime: "오후 6시 26분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "승빈", userProfile: "승빈_프로필", isPhoto: false, isSchedule: false, message: "그럼 언제가 좋을라나???", sendTime: "오후 7시 3분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "승빈", userProfile: "승빈_프로필", isPhoto: false, isSchedule: false, message: "더 추워지기 전에 가는게 좋을 것 같은데", sendTime: "오후 7시 6분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "나연", userProfile: "나연_프로필", isPhoto: false, isSchedule: false, message: "아무래도 그렇지..?", sendTime: "오후 7시 10분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "승빈", userProfile: "승빈_프로필", isPhoto: false, isSchedule: false, message: "일단 졸프부터 끝내고??????", sendTime: "오후 7시 11분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "본의", userProfile: "본의_프로필", isPhoto: false, isSchedule: false, message: "그래야지ㅠㅠㅠ", sendTime: "오후 7시 13분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "승빈", userProfile: "승빈_프로필", isPhoto: true, isSchedule: false, message: "", sendTime: "오후 8시 21분", emoticon: nil, photo: UIImage(named: "chat_image4"), scheduleDate: nil, scheduleTitle: nil),
        ChatMessage(userName: "승빈", userProfile: "승빈_프로필", isPhoto: false, isSchedule: false, message: "우리 귀요미 호두도 데리고 가쟝", sendTime: "오후 8시 21분", emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil),
        
    ]
    
    
    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
    @IBOutlet weak var inputViewBottomMargin: NSLayoutConstraint!
    
    @IBOutlet weak var tableViewBottomMargin: NSLayoutConstraint!
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var emoticonBaseViewHeight: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var scheduleTitleLabel: UITextField!
    @IBOutlet weak var scheduleStartTimePicker: UIDatePicker!
    
    var isFistLayoutSubviews = true
    var oldTableViewBottomInset: CGFloat = 0
    
    
    let imagePickerController = UIImagePickerController()
    
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
        userEmoticonBaseView.isHidden = true
        scheduleBaseView.isHidden = true
        schduleAllDaySwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stackView.isHidden = true
        IQKeyboardManager.shared().isEnabled = false
        
        setGesture()
        setTableView()
        setCollectionView()
        setKeyboardNotification()
        
        emoticonViewModel.chatView = self
        emoticonViewModel.getAllEmoticon()
        
        imagePickerController.delegate = self
        
        viewModel.chatView = self
        viewModel.getChatInfo()
        viewModel.reloadTableView = {
            
            self.chatTableView.reloadData()
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: { [self](completed) in
                let indexPath = IndexPath(row: ChatViewController.message.count - 1, section: 0)
                self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
//                if viewModel.chatInfo.count == 0 {
//                    let indexPath = IndexPath(row: 0, section: 0)
//                    self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
//                } else {
//                    let indexPath = IndexPath(row: self.viewModel.chatInfo.count - 1, section: 0)
//                    self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
//                }
            })
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.userEmoticonCollectionView.reloadData()
        viewModel.getChatInfo()
    }
    
    
    
    func setTableView() {
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.separatorStyle = .none
        chatTableView.register(UINib(nibName: "MyMessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MyMessageTableViewCell")
        chatTableView.register(UINib(nibName: "FamilyMessageTableViewCell", bundle: nil), forCellReuseIdentifier: "FamilyMessageTableViewCell")
        chatTableView.register(UINib(nibName: "MyPhotoMessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MyPhotoMessageTableViewCell")
        chatTableView.register(UINib(nibName: "FamilyPhotoMessageTableViewCell", bundle: nil), forCellReuseIdentifier: "FamilyPhotoMessageTableViewCell")
        chatTableView.register(UINib(nibName: "MyScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "MyScheduleTableViewCell")
        chatTableView.register(UINib(nibName: "FamilyScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "FamilyScheduleTableViewCell")
        
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: { [self](completed) in
            let indexPath = IndexPath(row: ChatViewController.message.count - 1, section: 0)
            self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
//
//            if viewModel.chatInfo.count == 0 {
//                let indexPath = IndexPath(row: 0, section: 0)
//                self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
//            } else {
//                let indexPath = IndexPath(row: self.viewModel.chatInfo.count - 1, section: 0)
//                self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
//            }
//
            
            
        })
    }
    
    func setCollectionView() {
        self.userEmoticonCollectionView.delegate = self
        self.userEmoticonCollectionView.dataSource = self
        self.userEmoticonCollectionView.register(UINib(nibName: "EmoticonInChatCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EmoticonInChatCollectionViewCell")
        self.userEmoticonCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      
        self.userEmoticonCollectionView.collectionViewLayout = createComporitionalLayout()
        
        
    }
    
    
    fileprivate func createComporitionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [self](sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            //아이템 사이즈
            
            //
            //            let width = self.userEmoticonCollectionView.frame.width
            //            let height = self.userEmoticonCollectionView.frame.height
            //            let itemsPerRow: CGFloat = 4
            //            let widthPadding = sectionInsets.left * (4)
            //            let itemsPerColumn: CGFloat = 2
            //            let heightPadding = sectionInsets.top * (3)
            //            let cellWidth = (width - widthPadding) / itemsPerRow
            //            let cellHeight = (height - heightPadding) / itemsPerColumn
            //
            //
            //            var size: CGFloat = 0
            //
            //            if cellWidth > cellHeight {
            //                size = cellHeight
            //
            //            } else {
            //                size = cellWidth
            //            }
            //
            //            print("size::: \(size)")
            //
            //
            //
            //            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(size), heightDimension: .absolute(size))
            //            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            //            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            //
            //
            //
            //            let groupHeight = NSCollectionLayoutDimension.fractionalWidth(1/4)
            //            let groupSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension, heightDimension: groupHeight)
            //            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 4)
            //
            //            let section = NSCollectionLayoutSection(group: group)
            //            section.orthogonalScrollingBehavior = .continuous
            //            section.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
            //            return section
            
            let fraction: CGFloat = 1 / 4
            let inset: CGFloat = 2.5

            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

            // Group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(fraction))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
            //section.orthogonalScrollingBehavior = .continuous
            // Supplementary Item
            //let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(self.userEmoticonCollectionView.frame.height))
//            let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(self.userEmoticonCollectionView.frame.height / 4))
//            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: "header", alignment: .top)
//            section.boundarySupplementaryItems = [headerItem]

            return section


    
            
        }
        return layout
    }
    
    
    fileprivate func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
    }
    
    fileprivate func supplementaryFooterSeparatorItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(1)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        
    }
    
//    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
//
//    let item = NSCollectionLayoutItem(layoutSize: itemSize)
//    let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
//
//    let containerGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),heightDimension: .estimated(1)), subitems: Array(repeating: group, count: 3))
//    containerGroup.interItemSpacing = .fixed(16)
//
//    let section = NSCollectionLayoutSection(group: containerGroup)
//    section.interGroupSpacing = 16
//    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)
//    section.supplementariesFollowContentInsets = false
//    section.orthogonalScrollingBehavior = .groupPaging
//    section.boundarySupplementaryItems = [supplementaryHeaderItem(), supplementaryFooterSeparatorItem()]
//    return section
    
    
    
    
    
    
    
    func setGesture() {
        let emoticonStackViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(emoticonStackViewAction))
        emoticonStackView.isUserInteractionEnabled = true
        emoticonStackView.addGestureRecognizer(emoticonStackViewTapGesture)
        
        let galleryStackViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(galleryStackViewAction))
        galleryStackView.isUserInteractionEnabled = true
        galleryStackView.addGestureRecognizer(galleryStackViewTapGesture)
        
        let cameraStackViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(cameraStackViewAction))
        cameraStackView.isUserInteractionEnabled = true
        cameraStackView.addGestureRecognizer(cameraStackViewTapGesture)
        
        let scheduleStackViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(scheduleStackViewAction))
        scheduleStackView.isUserInteractionEnabled = true
        scheduleStackView.addGestureRecognizer(scheduleStackViewTapGesture)
        
        
        let scheduleCategoryTapGesture = UITapGestureRecognizer(target: self, action: #selector(selectScheduleCategoryAction))
        self.selectScheduleCategory.isUserInteractionEnabled = true
        self.selectScheduleCategory.addGestureRecognizer(scheduleCategoryTapGesture)
        
        let showMoreScheduleOptionTapGesture = UITapGestureRecognizer(target: self, action: #selector(showMoreScheduleOptionAction))
        self.showMoreScheduleOption.isUserInteractionEnabled = true
        self.showMoreScheduleOption.addGestureRecognizer(showMoreScheduleOptionTapGesture)
        
    }
    
    func setKeyboardNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShowNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHideNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func selectScheduleCategoryAction(_ sender: UITapGestureRecognizer) {
        print("일정구분")
        let alert = UIAlertController(title: "일정 구분", message: "일정을 분류 해주세요", preferredStyle: .actionSheet)
        
        var birthdayImage = UIImage(named: "birthday_addDate")
        birthdayImage = birthdayImage?.imageWithSize(scaledToSize: CGSize(width: 32, height: 32))
        let addBirthDay = UIAlertAction(title: "기념일 및 생일", style: .default, handler: {[self] _ in
            selectScheduleCategory.image = UIImage(named: "birthday_addDate")
        })
        addBirthDay.setValue(birthdayImage?.withRenderingMode(.alwaysOriginal), forKey: "image")
        addBirthDay.setValue(UIColor.black, forKey: "titleTextColor")
        alert.addAction(addBirthDay)
        
        var familyImage = UIImage(named: "family_addDate")
        familyImage = familyImage?.imageWithSize(scaledToSize: CGSize(width: 32, height: 32))
        let addFamily = UIAlertAction(title: "가족", style: .default, handler: {[self] _ in
            selectScheduleCategory.image = UIImage(named: "family_addDate")
        })
        addFamily.setValue(familyImage?.withRenderingMode(.alwaysOriginal), forKey: "image")
        addFamily.setValue(UIColor.black, forKey: "titleTextColor")
        alert.addAction(addFamily)
        
        var personalImage = UIImage(named: "person_addDate")
        personalImage = personalImage?.imageWithSize(scaledToSize: CGSize(width: 32, height: 32))
        let addPersonal = UIAlertAction(title: "개인", style: .default, handler: {[self] _ in
            selectScheduleCategory.image = UIImage(named: "person_addDate")
        })
        addPersonal.setValue(personalImage?.withRenderingMode(.alwaysOriginal), forKey: "image")
        addPersonal.setValue(UIColor.black, forKey: "titleTextColor")
        alert.addAction(addPersonal)
        
        var normalImage = UIImage(named: "normal_addDate")
        normalImage = normalImage?.imageWithSize(scaledToSize: CGSize(width: 32, height: 32))
        let addNormal = UIAlertAction(title: "일반", style: .default, handler: {[self] _ in
            selectScheduleCategory.image = UIImage(named: "normal_addDate")
        })
        addNormal.setValue(normalImage?.withRenderingMode(.alwaysOriginal), forKey: "image")
        addNormal.setValue(UIColor.black, forKey: "titleTextColor")
        alert.addAction(addNormal)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        cancel.setValue(UIColor.FailyColor.coral, forKey: "titleTextColor")
        alert.addAction(cancel)
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func showMoreScheduleOptionAction(_ sender: UITapGestureRecognizer) {
        print("스케듈 옵션 더보기")
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let showMoreOptionVC = storyBoard.instantiateViewController(withIdentifier: "ScheduleInChatDetailViewController") as! ScheduleInChatDetailViewController
        showMoreOptionVC.modalPresentationStyle = .fullScreen
        
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.present(showMoreOptionVC, animated: false, completion: nil)
    }
    
    @objc func handleKeyboardShowNotification(_ sender: Notification) {
        
        let userInfo:NSDictionary = sender.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        print(keyboardRectangle)
        
        if isChat == true {
            
            if menuState == false {
                bottomMargin.constant =  keyboardRectangle.height - 22
            } else {
                bottomMargin.constant =  keyboardRectangle.height - 83
            }
        } else {
            scheduleViewBottomMargin.constant = keyboardRectangle.height - 250
            
        }
        
        
    }
    
    @objc func handleKeyboardHideNotification(_ sender: Notification) {
        
        let userInfo:NSDictionary = sender.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        print(keyboardRectangle)
        
        
        if isChat == true {
            bottomMargin.constant = 0
        } else {
            scheduleViewBottomMargin.constant = 0
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        IQKeyboardManager.shared().isEnabled = true
    }
    
    
    
    @objc func emoticonStackViewAction(_ sender: UITapGestureRecognizer) {
        //        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        //        let showUserEmoticonVC = storyBoard.instantiateViewController(withIdentifier: "EmoticonInChatViewController") as! EmoticonInChatViewController
        //        showUserEmoticonVC.modalPresentationStyle = .overCurrentContext
        //        present(showUserEmoticonVC, animated: false)
        userEmoticonBaseView.isHidden = false
        self.emoticonState = true
        self.bottomMargin.constant = self.bottomMargin.constant + 175
    }
    
    
    @objc func galleryStackViewAction(_ sender: UITapGestureRecognizer) {
        let imagePicker = ImagePickerController()
        imagePicker.settings.selection.max = 3
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
        
        
        PHPhotoLibrary.requestAuthorization { (auth_status) in
            if auth_status == .denied || auth_status == .notDetermined {
                print("권한허용하지 않음.")
            } else {
                self.presentImagePicker(imagePicker, select: { (asset) in
                    print("Selected: \(asset)")
                    
                }, deselect: { (asset) in
                    print("Deselected: \(asset)")
                }, cancel: { (assets) in
                    print("Canceled with selections: \(assets)")
                }, finish: { (assets) in
                    print("Finished with selections: \(assets)")
                    
                    
                    for i in 0..<assets.count {
                        self.selectedAssets.append(assets[i])
                        
                    }
                    self.convertAssetToImages()
                    
                    
                }, completion: {
                    let finish = Date()
                    print(finish.timeIntervalSince(start))
                })
                
                let options = imagePicker.settings.fetch.album.options
                imagePicker.settings.fetch.album.fetchResults = [
                    PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: options),
                    PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: options),
                ]
            }
        }
        
        
        
        
        
        
        
        
        
        //imagePicker.modalPresentationStyle = .currentContext
        //        self.presentImagePicker(imagePicker, select: { (asset) in
        //            print("Selected: \(asset)")
        //
        //        }, deselect: { (asset) in
        //            print("Deselected: \(asset)")
        //        }, cancel: { (assets) in
        //            print("Canceled with selections: \(assets)")
        //        }, finish: { (assets) in
        //            print("Finished with selections: \(assets)")
        //        }, completion: {
        //            let finish = Date()
        //            print(finish.timeIntervalSince(start))
        //        })
        
        
        
        
        
        
        
        
        
        //        let options = imagePicker.settings.fetch.album.options
        //        imagePicker.settings.fetch.album.fetchResults = [
        //            PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: options),
        //            PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: options),
        //        ]
    }
    
    func convertAssetToImages() {
        
        if selectedAssets.count != 0 {
            
            for i in 0..<selectedAssets.count {
                
                let imageManager = PHImageManager.default()
                let option = PHImageRequestOptions()
                option.isSynchronous = true
                var thumbnail = UIImage()
                
                imageManager.requestImage(for: selectedAssets[i],
                                             targetSize: CGSize(width: 3000, height: 3000),
                                             contentMode: .aspectFit,
                                             options: option) { (result, info) in
                    thumbnail = result!
                }
                
                let data = thumbnail.jpegData(compressionQuality: 1)
                let newImage = UIImage(data: data!)
                
                self.userSelectedImages.append(newImage! as UIImage)
                
                
                let myDateFormatter = DateFormatter()
                myDateFormatter.dateFormat = "a h시 m분"
                let time = myDateFormatter.string(from: Date())
                
                
                
                ChatViewController.message.append(ChatMessage(userName: "본의", userProfile: "본의_프로필", isPhoto: true, isSchedule: false, message: self.messageTextView.text, sendTime: time, emoticon: nil, photo: newImage, scheduleDate: nil, scheduleTitle: nil))
                
                GalleryViewController.recentPhotoAlbum.append(photoInfo(photoName: newImage!, isLoved: false))
                
            }
            
            GalleryViewController.totalAlbum[0] = totalAlbumInfo(album: GalleryViewController.recentPhotoAlbum, isloved: false, albumTitle: "최근 항목")
           
            
        }
        
        self.chatTableView.reloadData()
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: {(completed) in
            let indexPath = IndexPath(row: ChatViewController.message.count - 1, section: 0)
//            let indexPath = IndexPath(row: self.viewModel.chatInfo.count - 1, section: 0)
            self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
            self.selectedAssets = []
        })
    }
    
    
    @objc func cameraStackViewAction(_ sender: UITapGestureRecognizer) {
        
                switch PHPhotoLibrary.authorizationStatus() {
                case .denied:
                    settingAlert()
                case .restricted:
                    break
                case .authorized:
                    self.imagePickerController.sourceType = .camera
                    self.imagePickerController.allowsEditing = true
                    self.present(self.imagePickerController, animated: true, completion: nil)
                case .notDetermined:
                    PHPhotoLibrary.requestAuthorization({ state in
                        if state == .authorized {
                            DispatchQueue.main.async {
                                self.imagePickerController.sourceType = .camera
                                self.imagePickerController.allowsEditing = true
        
                                self.present(self.imagePickerController, animated: true, completion: nil)
                            }
        
                        } else {
                            self.dismiss(animated: true, completion: nil)
                        }
                    })
                default:
                    break
                }
        
//
//                self.imagePickerController.sourceType = .camera
//                self.imagePickerController.allowsEditing = true
//                self.present(self.imagePickerController, animated: true, completion: nil)
        
//        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "AllAnsweredPopUpInChatViewController") as! AllAnsweredPopUpInChatViewController
//        vc.modalPresentationStyle = .overCurrentContext
//        self.present(vc, animated: false, completion: nil)
//
        
    }
    
    
    func settingAlert() {
        if let appName = Bundle.main.infoDictionary!["CFBundelName"] as? String {
            let alert = UIAlertController(title: "설정", message: "\(appName)이(가) 카메라 접근 허영되어 있지 않습니다. 설정화면으로 사기셌습니다?", preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "취소", style: .default, handler: nil)
            let okButton = UIAlertAction(title: "확인", style: .default, handler: { _ in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            })
            
            alert.addAction(cancelButton)
            alert.addAction(okButton)
            
            self.present(alert, animated: true, completion: nil)
        } else {
            print("존재하지 않는 앱 아이디 입니다.")
        }
    }
    
    
    @objc func scheduleStackViewAction(_ sender: UITapGestureRecognizer) {
        //        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        //        let addScheduleView = storyBoard.instantiateViewController(withIdentifier: "ScheduleInChatViewController") as! ScheduleInChatViewController
        //        addScheduleView.modalPresentationStyle = .overCurrentContext
        //        present(addScheduleView, animated: false)
        
        self.isChat = false
        self.scheduleBaseView.isHidden = false
        self.bottomMargin.constant = self.bottomMargin.constant + self.scheduleBaseView.frame.height - 125
        
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
        
        guard let userMessage = messageTextView.text?.trim, userMessage.isExists else {
            print("빈 메세지 입니다. 전달되지 않습니다.")
            return
        }
        
        //message.append(ChatMessage(userName: "보니", message: self.messageTextView.text, profileImage: "boni", sendTime: "오후 11시 30분"))
        
        
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "a h시 m분"
        let time = myDateFormatter.string(from: Date())
        
        
        
        ChatViewController.message.append(ChatMessage(userName: "본의", userProfile: "본의_프로필", isPhoto: false, isSchedule: false, message: self.messageTextView.text, sendTime: time, emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil))
        self.chatTableView.reloadData()
        self.messageTextView.text = nil
        
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: { [self](completed) in
            let indexPath = IndexPath(row: ChatViewController.message.count - 1, section: 0)
            self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
//            if viewModel.chatInfo.count == 0 {
//                let indexPath = IndexPath(row: 0, section: 0)
//                self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
//            } else {
//                let indexPath = IndexPath(row: self.viewModel.chatInfo.count - 1, section: 0)
//                self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
//            }
        })
        
        self.messageTextView.becomeFirstResponder()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
            ChatViewController.message.append(ChatMessage(userName: "승빈", userProfile: "승빈_프로필", isPhoto: false, isSchedule: false, message: "저희는 가족만을 위한 서비스를 제공하는 페일리입니다", sendTime: time, emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil))
            self.chatTableView.reloadData()
            self.messageTextView.text = nil
            
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: { [self](completed) in
                let indexPath = IndexPath(row: ChatViewController.message.count - 1, section: 0)
                self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
    //            if viewModel.chatInfo.count == 0 {
    //                let indexPath = IndexPath(row: 0, section: 0)
    //                self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
    //            } else {
    //                let indexPath = IndexPath(row: self.viewModel.chatInfo.count - 1, section: 0)
    //                self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
    //            }
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    
                    ChatViewController.message.append(ChatMessage(userName: "승빈", userProfile: "승빈_프로필", isPhoto: false, isSchedule: false, message: "잘 부탁 드립니다🙏", sendTime: time, emoticon: nil, photo: nil, scheduleDate: nil, scheduleTitle: nil))
                    self.chatTableView.reloadData()
                    self.messageTextView.text = nil
                    
                    UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                        self.view.layoutIfNeeded()
                    }, completion: { [self](completed) in
                        let indexPath = IndexPath(row: ChatViewController.message.count - 1, section: 0)
                        self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
            //            if viewModel.chatInfo.count == 0 {
            //                let indexPath = IndexPath(row: 0, section: 0)
            //                self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
            //            } else {
            //                let indexPath = IndexPath(row: self.viewModel.chatInfo.count - 1, section: 0)
            //                self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
            //            }
                    })
                    
                    self.messageTextView.becomeFirstResponder()
                }
                

                
                
                
            })
            
            self.messageTextView.becomeFirstResponder()
        }
        
        
        

        
        
        
        
        //        if messageTextView.text != nil || messageTextView.text != "" {
        //            message.append(ChatMessage(userName: "보니", message: self.messageTextView.text, profileImage: "boni", sendTime: "오후 11시 30분"))
        //            self.chatTableView.reloadData()
        //            self.messageTextView.text = nil
        //            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
        //                self.view.layoutIfNeeded()
        //            }, completion: {(completed) in
        //                let indexPath = IndexPath(row: self.message.count - 1, section: 0)
        //                self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        //            })
        //        }
        
        //SoketIOManager.shared.sendMessage(message: "aaa", nickname: "구본의")
        
       //let param = SendChatRequest(file: "", content: "123123123", emoji: false, photo: false, calendar: false, text: true)
        //viewModel.postSendChat(param)
        
    }
    
    @IBAction func dismissEmoticonViewAction(_ sender: Any) {
        self.userEmoticonBaseView.isHidden = true
        self.emoticonState = false
        self.bottomMargin.constant = self.bottomMargin.constant - 175
    }
    
    
    @IBAction func sendEmoticonButtonAction(_ sender: Any) {
        
        if selectedEmoticon == nil {
            print("이모티콘을 선택해 주세요")
        } else {
            
            
            let myDateFormatter = DateFormatter()
            myDateFormatter.dateFormat = "a h시 m분"
            let time = myDateFormatter.string(from: Date())
            
            
            
            ChatViewController.message.append(ChatMessage(userName: "본의", userProfile: "본의_프로필", isPhoto: false, isSchedule: false, message: self.messageTextView.text, sendTime: time, emoticon: self.selectedEmoticon, photo: nil, scheduleDate: nil, scheduleTitle: nil))
            self.chatTableView.reloadData()
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: {(completed) in
                let indexPath = IndexPath(row: ChatViewController.message.count - 1, section: 0)
                //let indexPath = IndexPath(row: self.viewModel.chatInfo.count - 1, section: 0)
                self.selectedEmoticon = nil
                self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
            })
        }
        
        
    }
    
    
    @IBAction func dismissScheduleViewAction(_ sender: Any) {
        self.isChat = true
        self.scheduleBaseView.isHidden = true
        self.bottomMargin.constant = self.bottomMargin.constant - self.scheduleBaseView.frame.height + 125
       
    }
    
    
    @IBAction func sendScheduleButtonAction(_ sender: Any) {
        guard let title = scheduleTitleLabel.text?.trim, title.isExists else {return}
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일"
        let startDate = formatter.string(from: scheduleStartTimePicker.date)
        
        
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "a h시 m분"
        let time = myDateFormatter.string(from: Date())
        
        
        
        ChatViewController.message.append(ChatMessage(userName: "본의", userProfile: "본의_프로필", isPhoto: false, isSchedule: true, message: self.messageTextView.text, sendTime: time, emoticon: nil, photo: nil, scheduleDate: startDate, scheduleTitle: title))
        self.chatTableView.reloadData()
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: {(completed) in
            IQKeyboardManager.shared().isEnabled = false
            let indexPath = IndexPath(row: ChatViewController.message.count - 1, section: 0)
            //let indexPath = IndexPath(row: self.viewModel.chatInfo.count - 1, section: 0)
            self.selectedEmoticon = nil
            self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        })
    }
    
    
    
}


extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.message.count + 2
        return ChatViewController.message.count
        //viewModel.chatInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let chatMessage = viewModel.chatInfo[indexPath.row]
//        if chatMessage.sender_name == "구본의" {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "MyMessageTableViewCell", for: indexPath) as! MyMessageTableViewCell
//            cell.myMessageLabel.text = chatMessage.content
//            //cell.timeLabel.text = chatMessage.sendTime
//            cell.selectionStyle = .none
//            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyMessageTableViewCell", for: indexPath) as! FamilyMessageTableViewCell
//            cell.nameLabel.text = chatMessage.sender_name
//            cell.messageLabel.text = chatMessage.content
//            //cell.profileImage.image = UIImage(named: chatMessage.userProfile)
//            //cell.timeLabel.text = chatMessage.sendTime
//            cell.selectionStyle = .none
//            return cell
//        }
//
        
        let chatMessage = ChatViewController.message[indexPath.row]
        if chatMessage.isPhoto == false && chatMessage.isSchedule == false {

            if chatMessage.userName == "본의" {
                if chatMessage.emoticon != nil {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "MyPhotoMessageTableViewCell", for: indexPath) as! MyPhotoMessageTableViewCell
                    cell.selectionStyle = .none
                    cell.mySendImage.image = chatMessage.emoticon!
                    cell.timeLabel.text = chatMessage.sendTime
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "MyMessageTableViewCell", for: indexPath) as! MyMessageTableViewCell
                    cell.myMessageLabel.text = chatMessage.message
                    cell.timeLabel.text = chatMessage.sendTime
                    cell.selectionStyle = .none
                    return cell
                }


            } else {

                if chatMessage.emoticon != nil {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyPhotoMessageTableViewCell", for: indexPath) as! FamilyPhotoMessageTableViewCell
                    cell.timeLabel.text = chatMessage.sendTime
                    cell.selectionStyle = .none
                    return cell
                } else {

                    let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyMessageTableViewCell", for: indexPath) as! FamilyMessageTableViewCell
                    cell.nameLabel.text = chatMessage.userName
                    cell.messageLabel.text = chatMessage.message
                    cell.profileImage.image = UIImage(named: chatMessage.userProfile)
                    cell.timeLabel.text = chatMessage.sendTime
                    cell.selectionStyle = .none
                    return cell
                }
            }
        } else if chatMessage.isPhoto == true && chatMessage.isSchedule == false {
            if chatMessage.userName == "본의" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyPhotoMessageTableViewCell", for: indexPath) as! MyPhotoMessageTableViewCell
                cell.selectionStyle = .none
                cell.mySendImage.image = chatMessage.photo
                cell.timeLabel.text = chatMessage.sendTime
                return cell


            } else {


                let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyPhotoMessageTableViewCell", for: indexPath) as! FamilyPhotoMessageTableViewCell
                cell.familySendImage.image = chatMessage.photo
                cell.timeLabel.text = chatMessage.sendTime
                cell.nameLabel.text = chatMessage.userName
                cell.profileImage.image = UIImage(named: chatMessage.userProfile)
                cell.selectionStyle = .none
                return cell

            }
        } else if chatMessage.isSchedule == true {
            if chatMessage.userName == "본의" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyScheduleTableViewCell", for: indexPath) as! MyScheduleTableViewCell
                cell.selectionStyle = .none
                cell.scheduleTitleLabel.text = chatMessage.scheduleTitle
                cell.startDateLabel.text = chatMessage.sendTime

                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyScheduleTableViewCell", for: indexPath) as! FamilyScheduleTableViewCell
                cell.selectionStyle = .none
                return cell
            }
        }



        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyMessageTableViewCell", for: indexPath) as! MyMessageTableViewCell
            cell.myMessageLabel.text = chatMessage.message
            cell.timeLabel.text = chatMessage.sendTime
            cell.selectionStyle = .none
            return cell
        }
//        //-----------------
//
        
        
        //        if indexPath.row < 12 {
        //            let chatMessage = ChatViewController.message[indexPath.row]
        //            if chatMessage.userName == "본의"{
        //                let cell = tableView.dequeueReusableCell(withIdentifier: "MyMessageTableViewCell", for: indexPath) as! MyMessageTableViewCell
        //                cell.myMessageLabel.text = chatMessage.message
        //                cell.selectionStyle = .none
        //                return cell
        //            } else {
        //
        //
        //                let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyMessageTableViewCell", for: indexPath) as! FamilyMessageTableViewCell
        //                cell.nameLabel.text = chatMessage.userName
        //                cell.messageLabel.text = chatMessage.message
        //                cell.profileImage.image = UIImage(named: chatMessage.userProfile)
        //                cell.timeLabel.text = chatMessage.sendTime
        //                cell.selectionStyle = .none
        //                return cell
        //
        //
        //
        //            }
        //
        //
        //
        //        } else {
        //            if indexPath.row == 12 {
        //                let cell = tableView.dequeueReusableCell(withIdentifier: "MyPhotoMessageTableViewCell", for: indexPath) as! MyPhotoMessageTableViewCell
        //                cell.selectionStyle = .none
        //                return cell
        //            } else if indexPath.row == 13{
        //                let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyPhotoMessageTableViewCell", for: indexPath) as! FamilyPhotoMessageTableViewCell
        //                cell.selectionStyle = .none
        //                return cell
        //            } else if indexPath.row == 14{
        //                let cell = tableView.dequeueReusableCell(withIdentifier: "MyScheduleTableViewCell", for: indexPath) as! MyScheduleTableViewCell
        //                cell.selectionStyle = .none
        //                return cell
        //            } else {
        //                let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyScheduleTableViewCell", for: indexPath) as! FamilyScheduleTableViewCell
        //                cell.selectionStyle = .none
        //                return cell
        //            }
        //        }
        
    }
    
    
}


extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {

            let myDateFormatter = DateFormatter()
            myDateFormatter.dateFormat = "a h시 m분"
            let time = myDateFormatter.string(from: Date())
            
            ChatViewController.message.append(ChatMessage(userName: "본의", userProfile: "본의_프로필", isPhoto: true, isSchedule: false, message: self.messageTextView.text, sendTime: time, emoticon: nil, photo: image, scheduleDate: nil, scheduleTitle: nil))
            
            GalleryViewController.recentPhotoAlbum.append(photoInfo(photoName: image, isLoved: false))
            
            
            self.chatTableView.reloadData()
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: {(completed) in
                let indexPath = IndexPath(row: ChatViewController.message.count - 1, section: 0)
                //let indexPath = IndexPath(row: self.viewModel.chatInfo.count - 1, section: 0)
                self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
                self.selectedAssets = []
            })
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}


extension ChatViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return ChatViewController.emoticonArray.count
        //return 20
        
        return emoticonViewModel.chatEmoticonBox.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmoticonInChatCollectionViewCell", for: indexPath) as! EmoticonInChatCollectionViewCell
        
        
        var borderColor: CGColor = UIColor.clear.cgColor
        var borderWidth: CGFloat = 0
        
        if indexPath == self.selectedIndexPath {
            borderColor = UIColor.FailyColor.mainPinkColor.cgColor
            
            let imageData = Data(base64Encoded: emoticonViewModel.chatEmoticonBox[self.selectedIndexPath.item].emoji)
            let image = UIImage(data: imageData!)
            
            self.selectedEmoticon = image
            
            borderWidth = 3
        } else {
            borderColor = UIColor.FailyColor.grayscale_5.cgColor
            borderWidth = 1
        }
        
        cell.emoticonImageView.layer.borderWidth = borderWidth
        cell.emoticonImageView.layer.borderColor = borderColor
        
        
        let imageData = Data(base64Encoded: emoticonViewModel.chatEmoticonBox[indexPath.item].emoji)
        let image = UIImage(data: imageData!)
        
        cell.emoticonImageView.image = image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.userEmoticonCollectionView.allowsMultipleSelection = false
        self.selectedIndexPath = indexPath
    }
    
    
}

//
//extension ChatViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = self.userEmoticonCollectionView.frame.width
//        let height = self.userEmoticonCollectionView.frame.height
//        let itemsPerRow: CGFloat = 4
//        let widthPadding = sectionInsets.left * (4)
//        let itemsPerColumn: CGFloat = 2
//        let heightPadding = sectionInsets.top * (3)
//        let cellWidth = (width - widthPadding) / itemsPerRow
//        let cellHeight = (height - heightPadding) / itemsPerColumn
//
//
//        if cellWidth > cellHeight {
//            return CGSize(width: cellHeight, height: cellHeight)
//        } else if cellWidth == cellHeight {
//            return CGSize(width: cellWidth, height: cellHeight)
//        } else {
//            return CGSize(width: cellWidth, height: cellWidth)
//        }
//
//
//
//
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 0)
//
//
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return sectionInsets.left
//    }
//    ////
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return sectionInsets.left
//    }
//
//
//
//}
