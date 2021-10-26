//
//  EmoticonBoxViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/10/17.
//

import UIKit

class EmoticonBoxViewController: UIViewController {

    @IBOutlet weak var emoticonBoxCollectionView: UICollectionView!
    var imageArr = ["이모티콘1", "이모티콘2", "이모티콘3", "이모티콘4", "이모티콘5"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emoticonBoxCollectionView.reloadData()
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
        return ChatViewController.emoticonArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmoticonBoxCollectionViewCell", for: indexPath) as! EmoticonBoxCollectionViewCell
        cell.deleteButton.tag = indexPath.item
        cell.emoticonImageView.image = ChatViewController.emoticonArray[indexPath.item]
        cell.deleteButton.addTarget(self, action: #selector(deleteImage(sender:)), for: .touchUpInside)
        return cell
    }

    
    @objc func deleteImage(sender: UIButton) {
        print("\(sender.tag) 삭제")
        
        
        let alert = UIAlertController(title: "삭제", message: "해당 이모티콘을 삭제하시겠어요?", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "취소", style: .default, handler: nil)
        let okButton = UIAlertAction(title: "확인", style: .default, handler: {[self] _ in
            emoticonBoxCollectionView.deleteItems(at: [IndexPath.init(row: sender.tag, section: 0)])
            ChatViewController.emoticonArray.remove(at: sender.tag)
        })
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
        
       
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
