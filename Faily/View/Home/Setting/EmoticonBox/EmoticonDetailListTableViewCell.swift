//
//  EmoticonDetailListTableViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/10/08.
//

import UIKit

class EmoticonDetailListTableViewCell: UITableViewCell {

    @IBOutlet weak var emoticonListCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCollectionView() {
        emoticonListCollectionView.delegate = self
        emoticonListCollectionView.dataSource = self
        emoticonListCollectionView.register(UINib(nibName: "EmoticonDetailListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EmoticonDetailListCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension EmoticonDetailListTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmoticonDetailListCollectionViewCell", for: indexPath) as! EmoticonDetailListCollectionViewCell
        
        return cell
    }
}

