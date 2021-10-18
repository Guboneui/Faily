//
//  EmoticonInChatViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/10/18.
//

import UIKit

class EmoticonInChatViewController: UIViewController {

    
    
    @IBOutlet weak var emoticonCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        
    }
    
    func setCollectionView() {
        emoticonCollectionView.delegate = self
        emoticonCollectionView.dataSource = self
        emoticonCollectionView.register(UINib(nibName: "EmoticonInChatCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EmoticonInChatCollectionViewCell")
    }
    
    
    @IBAction func dismissButtonAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }

    

}

extension EmoticonInChatViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmoticonInChatCollectionViewCell", for: indexPath) as! EmoticonInChatCollectionViewCell
        return cell
    }
    
    
}
