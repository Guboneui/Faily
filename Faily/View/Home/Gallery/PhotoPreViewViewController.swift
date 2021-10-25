////
////  PhotoPreViewViewController.swift
////  Faily
////
////  Created by 구본의 on 2021/10/25.
////
//
//import UIKit
//
//class PhotoPreViewViewController: UIViewController {
//
//    @IBOutlet weak var previewCollectionView: UICollectionView!
//    var imageArr = ["sick_big", "happy_big", "mumu_big", "sad_big", "angry_big"]
//
//    var passedIndexPath: IndexPath = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setCollectionView()
//
//
//    }
//
//    var index: Int = 0
//
//    func setCollectionView() {
//        self.previewCollectionView.delegate = self
//        self.previewCollectionView.dataSource = self
//        self.previewCollectionView.register(UINib(nibName: "PhotoPreviewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoPreviewCollectionViewCell")
//        print("전달된 index = \(self.index)")
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        self.previewCollectionView.collectionViewLayout = layout
//
//        self.previewCollectionView.isPagingEnabled = false
//        self.previewCollectionView.layoutIfNeeded()
//        self.previewCollectionView.scrollToItem(at: IndexPath(item: self.index, section: 0), at: .centeredHorizontally, animated: false)
//        self.previewCollectionView.isPagingEnabled = true
//
//    }
//
//
//}
//
//extension PhotoPreViewViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return imageArr.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoPreviewCollectionViewCell", for: indexPath) as! PhotoPreviewCollectionViewCell
//        cell.image.image = UIImage(named: self.imageArr[indexPath.item])
//        return cell
//    }
//
//}
//
//extension PhotoPreViewViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return self.previewCollectionView.frame.size
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//}
