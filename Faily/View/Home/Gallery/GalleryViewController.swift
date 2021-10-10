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
import BSImagePicker


class GalleryViewController: UIViewController {
    
    
    
    let albumList = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil)
    
    var selectedAssets = [UIImage]()
    
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
        
        
    }
    
    
    
    @IBAction func goGallery(_ sender: Any) {
        let imagePicker = ImagePickerController()
        imagePicker.settings.selection.max = 5
        imagePicker.settings.theme.selectionStyle = .checked
        imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
        imagePicker.settings.selection.unselectOnReachingMax = false
        imagePicker.settings.theme.selectionFillColor = UIColor.FailyColor.secondaryPinkColor
        
        let start = Date()
        self.presentImagePicker(imagePicker, select: { (asset) in
            print("Selected: \(asset)")
        }, deselect: { (asset) in
            print("Deselected: \(asset)")
        }, cancel: { (assets) in
            print("Canceled with selections: \(assets)")
        }, finish: { (assets) in
            print("Finished with selections: \(assets)")
        }, completion: {
            let finish = Date()
            print(finish.timeIntervalSince(start))
        })
        let options = imagePicker.settings.fetch.album.options
        imagePicker.settings.fetch.album.fetchResults = [
            PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: options),
            PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: options),
        ]
        
    }
    
}
