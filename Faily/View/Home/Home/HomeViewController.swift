//
//  HomeViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/16.
//

import UIKit
import MKMagneticProgress
import MKColorPicker
import FSPagerView


struct UserInfo {
    let profileImage: String
    let userName: String
    let userFamiliar: Float
    let userEmotion: String
}

class HomeViewController: UIViewController {
    
    static var userInfo: [UserInfo] = [
        UserInfo(profileImage: "수빈_프로필", userName: "수빈", userFamiliar: 89.3, userEmotion: "sad_full"),
        UserInfo(profileImage: "본의_프로필", userName: "본의", userFamiliar: 79.1, userEmotion: "happy_full"),
        UserInfo(profileImage: "나연_프로필", userName: "나연", userFamiliar: 83.9, userEmotion: "mumu_full"),
        UserInfo(profileImage: "승빈_프로필", userName: "승빈", userFamiliar: 65.9, userEmotion: "sick_full")
    ]
    
    let imageArr = ["sick_big", "happy_big", "mumu_big", "sad_big", "angry_big"]
    
    
    let bmArr = ["bm1", "bm2", "bm3", "bm4", "bm5", "bm6", "bm7"]
    
    
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
   
    
    
    @IBOutlet weak var totalProgressBaseView: UIView!
    @IBOutlet weak var totalProgressBaseImageView: UIImageView!
    
    @IBOutlet weak var totalProgress: MKMagneticProgress!
    @IBOutlet weak var emotionBaseView: UIView!
    @IBOutlet weak var emotionBGView: UIImageView!
    
    @IBOutlet weak var emotionPagerView: FSPagerView! {
        didSet {
            self.emotionPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "emotionPagerViewCell")
            //self.emotionPagerView.itemSize = FSPagerView.automaticSize
            let transform = CGAffineTransform(scaleX: 0.45, y: 0.5)
            self.emotionPagerView.itemSize = self.emotionPagerView.frame.size.applying(transform)
            self.emotionPagerView.decelerationDistance = 10
            self.emotionPagerView.isInfinite = true
        }
    }
    
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var navTitleLabel: UILabel!
    @IBOutlet weak var navProfileImage: UIImageView!
    @IBOutlet weak var homeCalendarBaseView: UIView!
    @IBOutlet weak var homeCalendarContentsView: UIView!
    @IBOutlet weak var homeCalendarBGImageView: UIImageView!
    @IBOutlet weak var homeCalendarDateLabel: UILabel!
    @IBOutlet weak var memberProfileBaseView: UIView!
    @IBOutlet weak var memberProfileBGView: UIImageView!
    @IBOutlet weak var memberProfileCollectionView: UICollectionView!
    @IBOutlet weak var BusinessBaseView: UIView!
    @IBOutlet weak var BusinessBGView: UIImageView!
    @IBOutlet weak var BusinessCollectionView: UICollectionView!
    
    let progressColorPicker = ColorPickerViewController()
    let backgroundColorPicker = ColorPickerViewController()
    let titleColorPicker = ColorPickerViewController()
    let percentColorPicker = ColorPickerViewController()
    
    
    
    lazy var todayQuestionViewModel: TodayQuestionViewModel = TodayQuestionViewModel()
    
    
    
    func gradientLayer(bounds : CGRect,
                       color1: CGColor, color2: CGColor, color3: CGColor, color4: CGColor, color5: CGColor, color6: CGColor, color7: CGColor, color8: CGColor, color9: CGColor) -> CAGradientLayer{
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [color1, color2, color3, color4, color5, color6, color7, color8, color9]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradient
    }
    
    // 그래디언트 레이어로 그래디언트 색 만들기
    func gradientColor(gradientLayer :CAGradientLayer) -> UIColor? {
        UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, false, 0.0)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIColor(patternImage: image!)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        setCollectionView()
        todayQuestionViewModel.mainHome = self
        todayQuestionViewModel.getTodayQuestion()
        
    }
    
    func setCollectionView() {
        
        emotionPagerView.delegate = self
        emotionPagerView.dataSource = self
        emotionPagerView.transformer = FSPagerViewTransformer(type: .linear)
        
        
        memberProfileCollectionView.delegate = self
        memberProfileCollectionView.dataSource = self
        memberProfileCollectionView.register(UINib(nibName: "FamilyMemberCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FamilyMemberCollectionViewCell")
        
        
        BusinessCollectionView.delegate = self
        BusinessCollectionView.dataSource = self
        BusinessCollectionView.register(UINib(nibName: "HomeBusinessCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeBusinessCollectionViewCell")
    }
    
    func configUI() {
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.isHidden = true
        navProfileImage.layer.cornerRadius = navProfileImage.frame.height / 2
        totalProgressBaseView.layer.cornerRadius = 20
        makeShadow(totalProgressBaseView)
        
        totalProgressBaseImageView.layer.cornerRadius = 20
        
        
        var familyTotalProgress = 0
        for i in 0..<HomeViewController.userInfo.count {
            familyTotalProgress += Int(HomeViewController.userInfo[i].userFamiliar)
        }
        
        
        familyTotalProgress = familyTotalProgress / HomeViewController.userInfo.count
        
        self.percentLabel.text = "\(familyTotalProgress)%"
        
        totalProgress.setProgress(progress: CGFloat(familyTotalProgress) * 0.01, animated: true)
        totalProgress.progressShapeColor = .yellow
        totalProgress.backgroundShapeColor = .white
        totalProgress.lineWidth = 40
        totalProgress.spaceDegree = 90
        totalProgress.titleLabel.text = nil
        totalProgress.title = ""
        
        let bounds = self.totalProgress.bounds
        let color = gradientLayer(bounds: bounds, color1: UIColor.FailyColor.gradient1.cgColor, color2: UIColor.FailyColor.gradient2.cgColor, color3: UIColor.FailyColor.gradient3.cgColor, color4: UIColor.FailyColor.gradient4.cgColor, color5: UIColor.FailyColor.gradient5.cgColor, color6: UIColor.FailyColor.gradient6.cgColor, color7: UIColor.FailyColor.gradient7.cgColor, color8: UIColor.FailyColor.gradient8.cgColor, color9: UIColor.FailyColor.gradient9.cgColor)
        let realColor = gradientColor(gradientLayer: color)
        totalProgress.progressShapeColor = realColor!
        
        homeCalendarBaseView.layer.cornerRadius = 20
        makeShadow(homeCalendarBaseView)
        
        
        emotionBaseView.layer.cornerRadius = 20
        makeShadow(emotionBaseView)
        emotionBGView.layer.cornerRadius = 20
        
        
        
        homeCalendarBGImageView.layer.cornerRadius = 20
        
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd"
        let current_day_string = dayFormatter.string(from: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "eee"
        let current_date_string = dateFormatter.string(from: Date())
        
        let calendarLabelText = "\(current_day_string)\n\(current_date_string)"
        homeCalendarDateLabel.text = calendarLabelText
        
        
        let attributedString = NSMutableAttributedString(string: homeCalendarDateLabel.text!)
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: (homeCalendarDateLabel.text! as NSString).range(of: "\(current_day_string)"))
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: (homeCalendarDateLabel.text! as NSString).range(of: "\(current_day_string)"))
        
        attributedString.addAttribute(.foregroundColor, value: UIColor.FailyColor.grayscale_2, range: (homeCalendarDateLabel.text! as NSString).range(of: "\(current_date_string)"))
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 12), range: (homeCalendarDateLabel.text! as NSString).range(of: "\(current_date_string)"))
        
        
        homeCalendarDateLabel.attributedText = attributedString
        homeCalendarContentsView.layer.cornerRadius = 20
        
        memberProfileBaseView.layer.cornerRadius = 20
        makeShadow(memberProfileBaseView)
        memberProfileBGView.layer.cornerRadius = 20
        memberProfileCollectionView.layer.cornerRadius = 20
        //memberProfileCollectionView.allowsSelection = false
        
        BusinessBaseView.layer.cornerRadius = 20
        makeShadow(BusinessBaseView)
        BusinessBGView.layer.cornerRadius = 20
        
    }
    
    @IBAction func goPresentVCButtonAction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let mainPresentVC = storyBoard.instantiateViewController(withIdentifier: "PresentMainViewController") as! PresentMainViewController
        self.navigationController?.pushViewController(mainPresentVC, animated: true)
    }
    
    
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == memberProfileCollectionView {
            return HomeViewController.userInfo.count
        } else if collectionView == BusinessCollectionView {
            return self.bmArr.count
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == memberProfileCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FamilyMemberCollectionViewCell", for: indexPath) as! FamilyMemberCollectionViewCell
            cell.profileImage.image = UIImage(named: HomeViewController.userInfo[indexPath.item].profileImage)
            cell.memberNameLabel.text = HomeViewController.userInfo[indexPath.item].userName
            cell.userProgress = CGFloat(HomeViewController.userInfo[indexPath.item].userFamiliar * 0.01)
            cell.emotionImageView.image = UIImage(named: HomeViewController.userInfo[indexPath.item].userEmotion)
            return cell
        } else if collectionView == BusinessCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeBusinessCollectionViewCell", for: indexPath) as! HomeBusinessCollectionViewCell
            cell.bmImageView.image = UIImage(named: self.bmArr[indexPath.item])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeBusinessCollectionViewCell", for: indexPath) as! HomeBusinessCollectionViewCell
            return cell
        }
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("클릭")
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if collectionView == memberProfileCollectionView {
            let width = collectionView.frame.width
            let height = collectionView.frame.height

            let itemsPerRow: CGFloat = 2
            let widthPadding = sectionInsets.left * (itemsPerRow + 1)
            let itemsPerColumn: CGFloat = 3
            let heightPadding = sectionInsets.top * (itemsPerColumn + 1)

            let cellWidth = (width - widthPadding) / itemsPerRow
            let cellHeight = width * 0.6
            
            return CGSize(width: cellWidth, height: cellHeight)
//
//            let size = self.memberProfileCollectionView.frame.width / 2 - 11
//            let height = self.memberProfileCollectionView.frame.height / 2 - 10
//            return CGSize(width: size, height: height)
            
        } else if collectionView == BusinessCollectionView {
            let size = self.BusinessCollectionView.frame.height
            return CGSize(width: size, height: size)
        } else {
            return CGSize(width: 0, height: 0)
        }
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        
        if collectionView == memberProfileCollectionView {
            return 7.5
        } else if collectionView == BusinessCollectionView {
            return 30
        } else {
            return 0
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == memberProfileCollectionView {
            return 7.5
        } else if collectionView == BusinessCollectionView {
            return 30
        } else {
            return 0
        }
        
    }
    
    
    
}

extension HomeViewController: FSPagerViewDataSource, FSPagerViewDelegate {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageArr.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "emotionPagerViewCell", at: index)
        cell.imageView?.image = UIImage(named: self.imageArr[index])
        cell.imageView?.contentMode = .scaleAspectFit
       
        //cell.textLabel?.text = ...
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        //클릭 로직 해당 부분에 추가 필요
        print(index)
        return false
    }
}
