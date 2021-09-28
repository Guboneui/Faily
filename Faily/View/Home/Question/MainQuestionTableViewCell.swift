//
//  MainQuestionTableViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/09/27.
//

import UIKit
import CollectionViewPagingLayout

class MainQuestionTableViewCell: UITableViewCell {
    
    var dateArr = ["2021년 9월 24일", "2021년 9월 25일", "2021년 9월 26일", "2021년 9월 27일", "2021년 9월 28일", "2021년 9월 29일"]
    
    @IBOutlet weak var questionCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        print("awakeFromNib")
        questionCollectionView.delegate = self
        questionCollectionView.dataSource = self
        questionCollectionView.collectionViewLayout = CollectionViewPagingLayout()
        questionCollectionView.isPagingEnabled = false
        questionCollectionView.register(UINib(nibName: "MainQuestionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainQuestionCollectionViewCell")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("레이아웃")
        let collectionBounds = self.questionCollectionView.bounds
        let contentOffset = CGFloat(floor(self.questionCollectionView.contentOffset.x + (collectionBounds.size.width * CGFloat(dateArr.count))))
        print(collectionBounds.size.width)
        DispatchQueue.main.async {
            self.moveCollectionToFrame(contentOffset: contentOffset)
        }
        questionCollectionView.isPagingEnabled = true
    }
    
    func moveCollectionToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(
            x : contentOffset,
            y : self.questionCollectionView.contentOffset.y,
            width : self.questionCollectionView.frame.width,
            height : self.questionCollectionView.frame.height
        )
        self.questionCollectionView.scrollRectToVisible(frame, animated: false)
        print("move collection to frame")
    }

   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension MainQuestionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainQuestionCollectionViewCell", for: indexPath) as! MainQuestionCollectionViewCell
        cell.dateLabel.text = dateArr[indexPath.item]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일"
        let current_date_string = formatter.string(from: Date())
        if cell.dateLabel.text == current_date_string {
            cell.questionBox.image = UIImage(named: "questionBox_BookMark")
            cell.answerStackViewLabel.text = "답변하러 가기"
            cell.answerStackViewImage.image = UIImage(named: "pencil_gray")
            
            
        } else {
            cell.questionBox.image = UIImage(named: "questionBox_noBookMark")
            cell.answerStackViewLabel.text = "답변보러 가기"
            cell.answerStackViewImage.image = UIImage(named: "showAnswer")
            
        }
        return cell
    }
    
    //    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    //        var visibleRect = CGRect()
    //
    //        visibleRect.origin = questionCollectionView.contentOffset
    //        visibleRect.size = questionCollectionView.bounds.size
    //
    //        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
    //
    //        guard let indexPath = questionCollectionView.indexPathForItem(at: visiblePoint) else { return }
    //
    //        print(indexPath)
    //    }
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
}


