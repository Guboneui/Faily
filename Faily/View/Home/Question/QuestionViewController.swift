//
//  QuestionViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/16.
//

import UIKit
import CollectionViewPagingLayout

class QuestionViewController: UIViewController {
    
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    var collectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.register(UINib(nibName: "QuestionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "QuestionCollectionViewCell")
        mainCollectionView.collectionViewLayout = CollectionViewPagingLayout()
        mainCollectionView.isPagingEnabled = true
        
    }
    
    
    
}


extension QuestionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionCollectionViewCell", for: indexPath)
        return cell
    }
    
}

extension QuestionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        
        let cellWidth = self.mainCollectionView.frame.width * 0.6
        let cellHeight = self.mainCollectionView.frame.height * 0.5
        
        return CGSize(width: cellWidth, height: cellHeight)
        
        
        
        
        
    }
}
