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

struct PhotoAlbum {
    var title: String
    var count: Int
}

class UserGalleryCategoryViewController: UIViewController {
    
    var album: [PhotoAlbum] = []
    
    var thumbnail = [UIImage]()
    
    @IBOutlet weak var galleryTableView: UITableView!
    var albumTest = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        galleryTableView.delegate = self
        galleryTableView.dataSource = self
        galleryTableView.register(UINib(nibName: "GalleryTableViewCell", bundle: nil), forCellReuseIdentifier: "GalleryTableViewCell")
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
                            
                            print("\n\n \(title) --- count = \(photoInAlbum.count) \n\n")
                            self.album.append(PhotoAlbum(title: title, count: photoInAlbum.count))
                        }
                    }
                    
                    
                }
            }
            
            DispatchQueue.main.async {
                self.galleryTableView.reloadData()
            }
        }
    }
    
    
    
    
    
}

extension UserGalleryCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return album.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GalleryTableViewCell", for: indexPath) as! GalleryTableViewCell
        cell.albumTitle.text = album[indexPath.row].title
        cell.albumCountLabel.text = "\(album[indexPath.row].count)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = album[indexPath.row].title
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let aa = storyBoard.instantiateViewController(withIdentifier: "DeviceDetailGalleryViewController") as! DeviceDetailGalleryViewController
        aa.getTitle = title
        self.present(aa, animated: true, completion: nil)
        
    }
}
