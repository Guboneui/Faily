//
//  UserGalleryCategoryViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/10/09.
//

import UIKit
import Photos

struct DeviceAlbum {
    var thumbnail: UIImage?
    var title: String = ""
    var numberOfItems: Int = 0
    var collection: PHAssetCollection?
}


class UserGalleryCategoryViewController: UIViewController {

    
    var album = [String]()
    
    
    @IBOutlet weak var galleryTableView: UITableView!
    var albumTest = [UIImage]()
   
    override func viewDidLoad() {
        super.viewDidLoad()

        galleryTableView.delegate = self
        galleryTableView.dataSource = self
        galleryTableView.register(UINib(nibName: "GalleryTableViewCell", bundle: nil), forCellReuseIdentifier: "GalleryTableViewCell")
        get_Photos_From_Album(albumName: "인스타용")
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
                                           imgManager.requestImage(for: photoInAlbum.object(at: i) as PHAsset , targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFit, options: requestOptions, resultHandler: {
                                               image, error in
                                               if image != nil
                                               {
                                                   photoLibraryImages.append(image!)
    photoLibraryAssets.append(photoInAlbum.object(at: i))
                                               }
                                           })
                                       }
                                       
                                       self.albumTest = photoLibraryImages
                                       DispatchQueue.main.async {
                                           self.galleryTableView.reloadData()
                                       }
                                       
                                   }
                               }
                           }
                       }
                   }
               }
               
               
           }
    
    

}

extension UserGalleryCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumTest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GalleryTableViewCell", for: indexPath) as! GalleryTableViewCell
        cell.photo.image = albumTest[indexPath.row]
        return cell
    }
    
    
}
