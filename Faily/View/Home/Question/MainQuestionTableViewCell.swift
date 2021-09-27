//
//  MainQuestionTableViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/09/27.
//

import UIKit
import CollectionViewPagingLayout

class MainQuestionTableViewCell: UITableViewCell {

    
    var dateArr = ["2021년 9월 24일", "2021년 9월 25일", "2021년 9월 26일", "2021년 9월 27일", "2021년 9월 28일"]
    
    @IBOutlet weak var questionCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        questionCollectionView.delegate = self
        questionCollectionView.dataSource = self
        questionCollectionView.collectionViewLayout = CollectionViewPagingLayout()
        questionCollectionView.isPagingEnabled = true
        questionCollectionView.register(UINib(nibName: "MainQuestionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainQuestionCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MainQuestionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainQuestionCollectionViewCell", for: indexPath) as! MainQuestionCollectionViewCell
        cell.dateLabel.text = dateArr[indexPath.item]
   
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일"
        let current_date_string = formatter.string(from: Date())
        print(current_date_string)
        if cell.dateLabel.text == current_date_string {
            cell.questionBox.image = UIImage(named: "questionBox_BookMark")
            cell.answerStackView.isHidden = false
        } else {
            cell.questionBox.image = UIImage(named: "questionBox_noBookMark")
            cell.answerStackView.isHidden = true
        }
    
        
        return cell
    }
    
    
    
}
