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
    
    var seletedDate: String = ""
    var data: [ScheduleDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.calendarView = self
        viewModel.getAllSchedule()
        viewModelMethod()
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            self.data = []
            for i in 0..<viewModel.detailSchedule.count {
                //let date = viewModel.detailSchedule[i].calendar_start_time.substring(from: 0, to: 8)
                if viewModel.detailSchedule[i].calendar_date == seletedDate {
                    data.append(viewModel.detailSchedule[i])
                }
            }
            
            return data.count + 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarTableViewCell", for: indexPath) as! CalendarTableViewCell
            cell.selectionStyle = .none
            cell.mainCalendarView = self
            cell.schedule = self.viewModel.detailSchedule
            cell.addDateButton.addTarget(self, action: #selector(addDate), for: .touchUpInside)
            return cell
        } else {
            
            if indexPath.row == data.count {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BottomWhiteLabelTableViewCell", for: indexPath) as! BottomWhiteLabelTableViewCell
                cell.selectionStyle = .none
                return cell
            } else {
                
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "DateScheduleTableViewCell", for: indexPath) as! DateScheduleTableViewCell
                cell.selectionStyle = .none
                
                cell.editButton.addTarget(self, action: #selector(editSchedule), for: .touchUpInside)
                cell.deleteButton.addTarget(self, action: #selector(deleteSchedule), for: .touchUpInside)
                
                cell.scheduleTitleLabel.text = data[indexPath.row].calendar_name
                cell.scheduleDetailLabel.text = data[indexPath.row].calendar_memo
                
                if data[indexPath.row].calendar_category == "기념일" {
                    cell.firstBGView.image = UIImage(named: "birthday_baseBox")
                } else if data[indexPath.row].calendar_category == "가족" {
                    cell.firstBGView.image = UIImage(named: "family_baseBox")
                } else if data[indexPath.row].calendar_category == "개인" {
                    cell.firstBGView.image = UIImage(named: "personal_baseBox")
                } else {
                    cell.firstBGView.image = UIImage(named: "normal_baseBox")
                }
                
                
                //cell.addDateButton.addTarget(self, action: #selector(addDate), for: .touchUpInside)
                return cell
            }
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


extension CalendarViewController {
    func viewModelMethod() {
        viewModel.reloadTableView = {
            
            
            var formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            var current_date_string = formatter.string(from: Date())
            self.seletedDate = current_date_string
            print("테이블뷰가 reload 됩니다.")
            self.mainTableView.reloadData()
        }
    }
}
