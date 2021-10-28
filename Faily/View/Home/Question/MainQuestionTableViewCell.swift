//
//  MainQuestionTableViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/09/27.
//

import UIKit
import CollectionViewPagingLayout

protocol ReloadQuestionTableViewDelegate: AnyObject {
    func reloadQuestionTableView()
}

protocol ReloadMainQuestionTableViewDelegate: AnyObject {
    func reloadTableView()
}

class MainQuestionTableViewCell: UITableViewCell{
    
    @IBOutlet weak var questionCollectionView: UICollectionView!
    @IBOutlet weak var showAllQuestionStackView: UIStackView!
    
    var allQuestionData: [AllQuestionDetail] = []
    var questionView = QuestionViewController()
    weak var questionDelegate: ReloadQuestionTableViewDelegate?
    weak var delegate: ReloadMainQuestionTableViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setCollectionView()
        addGesture()
    }
    
    func setCollectionView() {
        questionCollectionView.delegate = self
        questionCollectionView.dataSource = self
        
        let layout = CollectionViewPagingLayout()
        layout.delegate = self
        questionCollectionView.collectionViewLayout = layout
        
        questionCollectionView.isPagingEnabled = true
        questionCollectionView.register(UINib(nibName: "MainQuestionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainQuestionCollectionViewCell")
    }
    
    func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goAnswerView))
        showAllQuestionStackView.addGestureRecognizer(tapGesture)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("MainQuestionTableViewCell - layoutSubviews")
        layoutIfNeeded()
        
        //**해당 부분 중복 호출로 인한 버그 발생 -> 상위 뷰인 QuestionViewController 에서 호출하는 방식으로 변경**
        //        questionCollectionView.isPagingEnabled = false
        //        let collectionBounds = self.questionCollectionView.bounds
        //        //let contentOffset = CGFloat(floor(self.questionCollectionView.contentOffset.x + (questionCollectionView.frame.width * CGFloat(self.allQuestionData.count))))
        //        let contentOffset = CGFloat(floor(self.questionCollectionView.contentOffset.x + collectionBounds.size.width * CGFloat(self.allQuestionData.count - 1)))
        //        //self.moveCollectionToFrame(contentOffset: contentOffset)
        //
        //        DispatchQueue.main.async {
        //            self.moveCollectionToFrame(contentOffset: contentOffset)
        //        }
        //
        //
        //        questionCollectionView.isPagingEnabled = true
        
    }
    
    func moveCollectionToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(
            x : contentOffset,
            y : self.questionCollectionView.contentOffset.y,
            width : self.questionCollectionView.frame.width,
            height : self.questionCollectionView.frame.height)
        
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseInOut, animations: {
            self.layoutIfNeeded()
        }, completion: {(completed) in
            self.questionCollectionView.scrollRectToVisible(frame, animated: false)
        })
    }
    
    @objc func goAnswerView(_ recognizer: UITapGestureRecognizer) {
        
        
        
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let allAnswerVC = storyBoard.instantiateViewController(withIdentifier: "AllAnswerViewController") as! AllAnswerViewController
        allAnswerVC.modalPresentationStyle = .overCurrentContext
        allAnswerVC.allAnswerData = self.allQuestionData
        self.window?.rootViewController?.present(allAnswerVC, animated: true, completion: nil)
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension MainQuestionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return dateArr.count
        return self.allQuestionData.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainQuestionCollectionViewCell", for: indexPath) as! MainQuestionCollectionViewCell
        let questionDeatil = self.allQuestionData[indexPath.item]
        cell.getQuestionIndex = questionDeatil.question_index
        cell.question = questionDeatil.question
        cell.delegate = self
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        let current_date_string = formatter.string(from: Date())
        
        
        cell.questionLabel.text = questionDeatil.question
        cell.dateLabel.text = questionDeatil.date
   
        
        if questionDeatil.isAnswered == false {
            cell.questionBox.image = UIImage(named: "questionBox_noBookMark")
            cell.answerStackViewLabel.text = "답변하러 가기"
            cell.answerStackViewImage.image = UIImage(named: "pencil_gray")
            cell.answerStackView.isHidden = false
        } else {
            cell.answerStackView.isHidden = true
        }
        
        if questionDeatil.date == current_date_string {
            cell.questionBox.image = UIImage(named: "questionBox_BookMark")
           

        } else {
            cell.questionBox.image = UIImage(named: "questionBox_noBookMark")
           

        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    //        let x = targetContentOffset.pointee.x
    //        let currentPage = Int(x / questionCollectionView.frame.width)
    //        print("currentpage = \(currentPage)")
    //        questionView.mainQuestionPage = currentPage
    //
    //    }
    //
}
extension MainQuestionTableViewCell: CollectionViewPagingLayoutDelegate {
    func onCurrentPageChanged(layout: CollectionViewPagingLayout, currentPage: Int) {
        print(currentPage)
        print("collectionview paging layout delegate")
        questionView.mainQuestionPage = currentPage
        self.questionDelegate?.reloadQuestionTableView()
    }
}

extension MainQuestionTableViewCell: ReloadMainQuestionCollectionViewDelegate {
    func reloadCollectionView() {
        delegate?.reloadTableView()
    }
    
    
}
