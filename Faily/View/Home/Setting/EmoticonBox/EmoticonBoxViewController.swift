//
//  EmoticonBoxViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/10/17.
//

import UIKit

class EmoticonBoxViewController: UIViewController {

    @IBOutlet weak var emoticonBoxCollectionView: UICollectionView!
    var imageArr = ["sick_big", "happy_big", "mumu_big", "sad_big", "angry_big"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        // Do any additional setup after loading the view.
    }
    
    func setCollectionView() {
        emoticonBoxCollectionView.delegate = self
        emoticonBoxCollectionView.dataSource = self
        emoticonBoxCollectionView.register(UINib(nibName: "EmoticonBoxCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EmoticonBoxCollectionViewCell")
    }

    @IBAction func newEmoticonButtonAction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let newEmoticonVC = storyBoard.instantiateViewController(withIdentifier: "MakeEmoticonViewController") as! MakeEmoticonViewController
        self.navigationController?.pushViewController(newEmoticonVC, animated: true)
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension EmoticonBoxViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmoticonBoxCollectionViewCell", for: indexPath) as! EmoticonBoxCollectionViewCell
        cell.deleteButton.tag = indexPath.item
        cell.emoticonImageView.image = UIImage(named: self.imageArr[indexPath.item])
        cell.deleteButton.addTarget(self, action: #selector(deleteImage(sender:)), for: .touchUpInside)
        return cell
    }

    
    @objc func deleteImage(sender: UIButton) {
        print("\(sender.tag) 삭제")
        emoticonBoxCollectionView.deleteItems(at: [IndexPath.init(row: sender.tag, section: 0)])
        imageArr.remove(at: sender.tag)
    }
}

extension EmoticonBoxViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = emoticonBoxCollectionView.frame.width
        let itemsPerRow: CGFloat = 3
        let widthPadding = 12 * (itemsPerRow + 1)
        let cellWidth = (width - widthPadding) / itemsPerRow
        return CGSize(width: cellWidth, height: cellWidth)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}
