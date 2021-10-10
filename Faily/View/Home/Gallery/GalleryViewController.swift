//
//  GalleryViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/16.
//

import UIKit
import PhotosUI
import Photos





class GalleryViewController: UIViewController {
    
    
    
    let albumList = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        print(albumList.count)

        for i in 0..<albumList.count {
            let album = albumList.object(at: i)
              // eg. get the name of the album
              print(album.localizedTitle)
        }
    }
    
    @IBAction func goGallery(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let aa = storyBoard.instantiateViewController(withIdentifier: "UserGalleryCategoryViewController") as! UserGalleryCategoryViewController
        aa.modalPresentationStyle = .overCurrentContext
        self.present(aa, animated: true, completion: nil)
        
        
    }
    
}
