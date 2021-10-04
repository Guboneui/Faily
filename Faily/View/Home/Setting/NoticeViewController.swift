//
//  NoticeViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/10/05.
//

import UIKit

class NoticeViewController: UIViewController {

    @IBOutlet weak var noticeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
    }
    

    func setTableView() {
        noticeTableView.delegate = self
        noticeTableView.dataSource = self
        noticeTableView.register(UINib(nibName: "NoticeTableViewCell", bundle: nil), forCellReuseIdentifier: "NoticeTableViewCell")
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension NoticeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeTableViewCell", for: indexPath) as! NoticeTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let detailNoticeVC = storyBoard.instantiateViewController(withIdentifier: "DetailNoticeViewController")
        detailNoticeVC.modalPresentationStyle = .overCurrentContext
        self.navigationController?.pushViewController(detailNoticeVC, animated: true)
    }
    
}
