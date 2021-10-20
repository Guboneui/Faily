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
    
    lazy var viewModel = GetAllScheduleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.calendarView = self
        viewModel.getAllSchedule()
        setTableView()
    }

    
    func setTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(UINib(nibName: "CalendarTableViewCell", bundle: nil), forCellReuseIdentifier: "CalendarTableViewCell")
        mainTableView.register(UINib(nibName: "DateScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "DateScheduleTableViewCell")
        mainTableView.register(UINib(nibName: "BottomWhiteLabelTableViewCell", bundle: nil), forCellReuseIdentifier: "BottomWhiteLabelTableViewCell")
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.separatorStyle = .none
        
        mainTableView.estimatedRowHeight = 20
    }
    
}


extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarTableViewCell", for: indexPath) as! CalendarTableViewCell
            cell.selectionStyle = .none
            cell.schedule = self.viewModel.detailSchedule
            cell.addDateButton.addTarget(self, action: #selector(addDate), for: .touchUpInside)
            return cell
        } else if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BottomWhiteLabelTableViewCell", for: indexPath) as! BottomWhiteLabelTableViewCell
            cell.selectionStyle = .none
            return cell
        }
        
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateScheduleTableViewCell", for: indexPath) as! DateScheduleTableViewCell
            cell.selectionStyle = .none
            
            
            cell.editButton.addTarget(self, action: #selector(editSchedule), for: .touchUpInside)
            cell.deleteButton.addTarget(self, action: #selector(deleteSchedule), for: .touchUpInside)
            
            
            
            if indexPath.row == 1 {
                cell.firstBGView.image = UIImage(named: "birthday_baseBox")
            } else if indexPath.row == 2 {
                cell.firstBGView.image = UIImage(named: "family_baseBox")
            } else if indexPath.row == 3 {
                cell.firstBGView.image = UIImage(named: "normal_baseBox")
            } else if indexPath.row == 4 {
                cell.firstBGView.image = UIImage(named: "personal_baseBox")
            }
            
            
            
            //cell.addDateButton.addTarget(self, action: #selector(addDate), for: .touchUpInside)
            return cell
            
        }
    }
    
    @objc func addDate() {
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let addDateNAV = storyBoard.instantiateViewController(identifier: "AddDateNavigationController") as! AddDateNavigationController
        presentPanModal(addDateNAV)
    }
    
    @objc func editSchedule() {
        print("일정 수정")
        self.presentAlert(title: "일정 수정")
    }
    
    @objc func deleteSchedule() {
        print("일정 삭제")
        self.presentAlert(title: "일정 삭제")
    }
    
    
}
