//
//  MainQuestionTableViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/09/27.
//

import UIKit
import CollectionViewPagingLayout

class MainQuestionTableViewCell: UITableViewCell {

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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainQuestionCollectionViewCell", for: indexPath) as! MainQuestionCollectionViewCell
        return cell
    }
    
    
    
}
