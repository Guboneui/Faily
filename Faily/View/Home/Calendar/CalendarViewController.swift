//
//  CalendarViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/16.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController {
    
   
    @IBOutlet weak var mainTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    func setTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(UINib(nibName: "CalendarTableViewCell", bundle: nil), forCellReuseIdentifier: "CalendarTableViewCell")
        mainTableView.register(UINib(nibName: "DateScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "DateScheduleTableViewCell")
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.separatorStyle = .none
        
        mainTableView.estimatedRowHeight = 20
    }
    
}


extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarTableViewCell", for: indexPath) as! CalendarTableViewCell
            cell.selectionStyle = .none
            cell.addDateButton.addTarget(self, action: #selector(addDate), for: .touchUpInside)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateScheduleTableViewCell", for: indexPath) as! DateScheduleTableViewCell
            cell.selectionStyle = .none
            //cell.addDateButton.addTarget(self, action: #selector(addDate), for: .touchUpInside)
            return cell
            
        }
    }
    
    @objc func addDate() {
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let addDateNAV = storyBoard.instantiateViewController(identifier: "AddDateNavigationController") as! AddDateNavigationController
        presentPanModal(addDateNAV)
    }
    
    
}
