//
//  ScheduleDivisionViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/23.
//

import UIKit

class ScheduleDivisionViewController: UIViewController {

    
    @IBOutlet weak var scheduleTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
    }
    
    func setTableView() {
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        scheduleTableView.rowHeight = 25
        scheduleTableView.register(UINib(nibName: "ScheduleDivisionTableViewCell", bundle: nil), forCellReuseIdentifier: "ScheduleDivisionTableViewCell")
    }

    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ScheduleDivisionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleDivisionTableViewCell", for: indexPath) as! ScheduleDivisionTableViewCell
        
        return cell
    }
    
    
}
