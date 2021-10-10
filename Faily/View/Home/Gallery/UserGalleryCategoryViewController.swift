//
//  UserGalleryCategoryViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/10/09.
//

import UIKit
import Photos

struct YPAlbum {
    var thumbnail: UIImage?
    var title: String = ""
    var numberOfItems: Int = 0
    var collection: PHAssetCollection?
}


class UserGalleryCategoryViewController: UIViewController {

    @IBOutlet weak var galleryTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

//phfetchoptions
