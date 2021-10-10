//
//  DeviceDetailGalleryViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/10/11.
//

import UIKit
import Photos
import AVFoundation
import AVKit

class DeviceDetailGalleryViewController: UIViewController {

    @IBOutlet weak var galleryCollectionView: UICollectionView!
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    var photos = [UIImage]()
    var getTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        galleryCollectionView.register(UINib(nibName: "DeviceDetailGalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DeviceDetailGalleryCollectionViewCell")
        
        get_Photos_From_Album(albumName: getTitle!)
    }
    
    func get_Photos_From_Album(albumName: String)
    {
        var photoLibraryImages = [UIImage]()
        var photoLibraryAssets = [PHAsset]()
        //whatever you need, you can use UIImage or PHAsset to photos in UICollectionView
        
        DispatchQueue.global(qos: .userInteractive).async
        {
            let fetchOptions = PHFetchOptions()
            fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
            
            let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)
            let customAlbums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)
            
            [smartAlbums, customAlbums].forEach {
                $0.enumerateObjects { collection, index, stop in
                    
                    let imgManager = PHImageManager.default()
                    
                    let requestOptions = PHImageRequestOptions()
                    requestOptions.isSynchronous = true
                    requestOptions.deliveryMode = .highQualityFormat
                    
                    let photoInAlbum = PHAsset.fetchAssets(in: collection, options: fetchOptions)
                    
                    if let title = collection.localizedTitle
                    {
                        if photoInAlbum.count > 0
                        {
                            print("\n\n \(title) --- count = \(photoInAlbum.count) \n\n")
                        }
                        
                        if title == albumName
                        {
                            if photoInAlbum.count > 0
                            {
                                for i in (0..<photoInAlbum.count).reversed()
                                {
                                    imgManager.requestImage(for: photoInAlbum.object(at: i) as PHAsset , targetSize: CGSize(width: 500, height: 500), contentMode: .aspectFit, options: requestOptions, resultHandler: {
                                        image, error in
                                        if image != nil
                                        {
                                            photoLibraryImages.append(image!)
                                            photoLibraryAssets.append(photoInAlbum.object(at: i))
                                        }
                                    })
                                    
                                }
                                
                                
                            }
                        }
                        
                        self.photos = photoLibraryImages
                        DispatchQueue.main.async {
                            self.galleryCollectionView.reloadData()
                            
                        }
                        
                    }
                }
            }
        }
    }


}

extension DeviceDetailGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeviceDetailGalleryCollectionViewCell", for: indexPath) as! DeviceDetailGalleryCollectionViewCell
        cell.photo.image = photos[indexPath.item]
        return cell
    }
    
    
}

extension DeviceDetailGalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.frame.width
            let height = collectionView.frame.height
            
            let itemsPerRow: CGFloat = 4
            let widthPadding = sectionInsets.left * (itemsPerRow + 1)
            let itemsPerColumn: CGFloat = 3
            let heightPadding = sectionInsets.top * (itemsPerColumn + 1)
            
            let cellWidth = (width - widthPadding) / itemsPerRow
            let cellHeight = (height - heightPadding) / itemsPerColumn
            
            
            return CGSize(width: cellWidth, height: cellWidth)
        }
        
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            insetForSectionAt section: Int) -> UIEdgeInsets {
          return sectionInsets
        }
        
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return sectionInsets.left
        }
}

