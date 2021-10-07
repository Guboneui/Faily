//
//  EmoticonBoxViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/10/08.
//

import UIKit

class EmoticonBoxViewController: UIViewController {

    @IBOutlet weak var emoticonBoxTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        // Do any additional setup after loading the view.
    }
    
    func setTableView() {
        emoticonBoxTableView.delegate = self
        emoticonBoxTableView.dataSource = self
        emoticonBoxTableView.separatorStyle = .none
        
        emoticonBoxTableView.register(UINib(nibName: "SelectedEmoticonPhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectedEmoticonPhotoTableViewCell")
        emoticonBoxTableView.register(UINib(nibName: "EmoticonListTableViewCell", bundle: nil), forCellReuseIdentifier: "EmoticonListTableViewCell")
        emoticonBoxTableView.register(UINib(nibName: "EmoticonDetailListTableViewCell", bundle: nil), forCellReuseIdentifier: "EmoticonDetailListTableViewCell")
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "저장", message: "", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "취소", style: .default, handler: nil)
        let okButton = UIAlertAction(title: "확인", style: .default, handler: {[self] _ in
            navigationController?.popViewController(animated: true)
        })
        
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    

}

extension EmoticonBoxViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedEmoticonPhotoTableViewCell", for: indexPath) as! SelectedEmoticonPhotoTableViewCell
            cell.selectionStyle = .none
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmoticonListTableViewCell", for: indexPath) as! EmoticonListTableViewCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmoticonDetailListTableViewCell", for: indexPath) as! EmoticonDetailListTableViewCell
            cell.selectionStyle = .none
            return cell
            
        }
        
        
    }
    
    
}
