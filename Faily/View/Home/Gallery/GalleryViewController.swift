//
//  GalleryViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/16.
//

import UIKit
import PhotosUI
import Photos
import AVFoundation
import AVKit


class GalleryViewController: UIViewController {
    
    
    
    let albumList = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil)
    
    var album: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(albumList.count)
        
//        for i in 0..<albumList.count {
//            let album = albumList.object(at: i)
//            // eg. get the name of the album
//            print(album.localizedTitle)
//
//
//        }
        
        get_All_Albums()
    }
    
    func get_All_Albums(){
            DispatchQueue.global(qos: .userInteractive).async
            {
                let fetchOptions = PHFetchOptions()
                fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)

                let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)
                let customAlbums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)

                [smartAlbums, customAlbums].forEach {
                    $0.enumerateObjects { collection, index, stop in

                        let requestOptions = PHImageRequestOptions()
                        requestOptions.isSynchronous = true
                        requestOptions.deliveryMode = .highQualityFormat

                        let photoInAlbum = PHAsset.fetchAssets(in: collection, options: fetchOptions)

                        if let title = collection.localizedTitle
                        {
                            if photoInAlbum.count > 0
                            {
                                self.album.append(title)
                                print("\n\n \(title) --- count = \(photoInAlbum.count) \n\n")
                            }
                        }
                    }
                }
            }
    }
    
    
    @IBAction func goGallery(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let aa = storyBoard.instantiateViewController(withIdentifier: "UserGalleryCategoryViewController") as! UserGalleryCategoryViewController
        aa.album = self.album
        self.present(aa, animated: true, completion: nil)
        
        
    }
    
}
