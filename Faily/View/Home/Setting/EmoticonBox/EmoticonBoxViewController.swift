//
//  EmoticonBoxViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/10/17.
//

import UIKit

class EmoticonBoxViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func newEmoticonButtonAction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let newEmoticonVC = storyBoard.instantiateViewController(withIdentifier: "MakeEmoticonViewController") as! MakeEmoticonViewController
        self.navigationController?.pushViewController(newEmoticonVC, animated: true)
    }
}
