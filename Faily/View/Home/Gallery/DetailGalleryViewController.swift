//
//  DetailGalleryViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/10/25.
//

import UIKit
import Photos

class DetailGalleryViewController: UIViewController {

    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    var imageArr = ["sick_big", "happy_big", "mumu_big", "sad_big", "angry_big"]
    var imageArray = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
    }
    
    func setCollectionView() {
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.register(UINib(nibName: "DetailGalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailGalleryCollectionViewCell")
        
    }
    
    func grabPhotos() {
        imageArray = []
        
        DispatchQueue.global(qos: .background).async {
            print("this is run on the background queue")
            let imgManager = PHImageManager.default()
            
            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous = true
            requestOptions.deliveryMode = .highQualityFormat
            
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            
            let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            print(fetchResult)
            print(fetchResult.count)
            
            if fetchResult.count > 0 {
                for i in 0..<fetchResult.count {
                    imgManager.requestImage(for: fetchResult.object(at: i) as PHAsset, targetSize: CGSize(width: 500, height: 500), contentMode: .aspectFill, options: requestOptions, resultHandler: { (image, error) in
                        self.imageArray.append(image!)
                    })
                }
            } else {
                print("yout got no photo")
            }
            print("imageArray.count: \(self.imageArray.count)")
            
            DispatchQueue.main.async {
                self.photoCollectionView.reloadData()
            }
            
        }
    }

    @IBAction func dismissViewButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension DetailGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GalleryViewController.recentPhotoAlbum.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailGalleryCollectionViewCell", for: indexPath) as! DetailGalleryCollectionViewCell
        cell.photo.image = UIImage(named: GalleryViewController.recentPhotoAlbum[indexPath.item].photoName)
        
        if GalleryViewController.recentPhotoAlbum[indexPath.item].isLoved == true {
            cell.heart.isHidden = false
        } else {
            cell.heart.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let previewVC = storyBoard.instantiateViewController(withIdentifier: "PhotoPreViewViewController") as! PhotoPreViewViewController
        //previewVC(inde)
        previewVC.index = indexPath.item
        //let previewVC = PhotoPreViewViewController(index: indexPath.item)
        self.navigationController?.pushViewController(previewVC, animated: true)
    }
    
}

extension DetailGalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.photoCollectionView.frame.width
        return CGSize(width: width / 3 - 1, height: width / 3 - 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}


