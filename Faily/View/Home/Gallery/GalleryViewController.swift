//
//  GalleryViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/16.
//

import UIKit

class GalleryViewController: UIViewController {
    
   
    @IBOutlet weak var galleryCategoryTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setTableView()
        
    }
    
    func setTableView() {
        galleryCategoryTableView.delegate = self
        galleryCategoryTableView.dataSource = self
        galleryCategoryTableView.separatorStyle = .none
        galleryCategoryTableView.register(UINib(nibName: "GalleryCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "GalleryCategoryTableViewCell")
        galleryCategoryTableView.register(UINib(nibName: "BottomWhiteLabelTableViewCell", bundle: nil), forCellReuseIdentifier: "BottomWhiteLabelTableViewCell")
        
        
    }
    
    
    @IBAction func addGalleryCategoryAction(_ sender: Any) {
        let alert = UIAlertController(title: "갤러리", message: "추가할 카테고리 이름을 입력 해주세요.", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "카테고리"
        }
        let cancelButton = UIAlertAction(title: "취소", style: .default, handler: nil)
        let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

extension GalleryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BottomWhiteLabelTableViewCell", for: indexPath) as! BottomWhiteLabelTableViewCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GalleryCategoryTableViewCell", for: indexPath) as! GalleryCategoryTableViewCell
            cell.selectionStyle = .none
            
            return cell
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 4 {
            return UITableView.automaticDimension
        } else {
            
            return 100
        }
    }
    
    
}
