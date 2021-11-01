//
//  AllAnswerBaseTableViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/09/29.
//

import UIKit
import ExpyTableView

class AllAnswerBaseTableViewCell: UITableViewCell {
  
    
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var familyCollectionVIew: UICollectionView!
    @IBOutlet weak var dropdownImage: UIImageView!
    
    var getMemberCount: Int = 0
    
    var data: [AnswerInfo] = []
    var indexPathItem = -1
    override func awakeFromNib() {
        super.awakeFromNib()
        setCollectionView()
    }
    
    func setCollectionView() {
        familyCollectionVIew.delegate = self
        familyCollectionVIew.dataSource = self
        familyCollectionVIew.register(UINib(nibName: "AllAnswerProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AllAnswerProfileCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension AllAnswerBaseTableViewCell: ExpyTableViewHeaderCell{
    func changeState(_ state: ExpyState, cellReuseStatus cellReuse: Bool) {
        print("MyHeaderCell - state: \(state)")
        switch state {
        case .willExpand:
            print("펼쳐질 예정")
            self.dropdownImage.image = UIImage(named: "question_dropdown")
        case .willCollapse:
            print("접힐 예정")
            self.dropdownImage.image = UIImage(named: "question_dropup")
        case .didExpand:
            print("펼쳐짐")
        case .didCollapse:
            print("접혀짐")
        }
    }
    
    
}

extension AllAnswerBaseTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return self.getMemberCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllAnswerProfileCollectionViewCell", for: indexPath) as! AllAnswerProfileCollectionViewCell
        
        
        
        if self.data[indexPath.item].user_name == "원승빈" {
            cell.familyProfileImage.image = UIImage(named: "승빈_프로필")
           
        } else if self.data[indexPath.item].user_name == "장나연" {
            cell.familyProfileImage.image = UIImage(named: "나연_프로필")
           
        } else if self.data[indexPath.item].user_name == "정수빈" {
            cell.familyProfileImage.image = UIImage(named: "수빈_프로필")
           
        } else {
            cell.familyProfileImage.image = UIImage(named: "본의_프로필")
           
        }
    
        
        
        print("컬렉션뷰 생성")
        return cell
    }
}

extension AllAnswerBaseTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = self.familyCollectionVIew.frame.height - 2
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
       
    }
}
