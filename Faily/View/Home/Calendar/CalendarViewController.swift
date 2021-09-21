//
//  CalendarViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/16.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var calendarBaseView: UIView!
    @IBOutlet weak var calendarBGView: UIImageView!
    @IBOutlet weak var calendarHeadLabel: UILabel!
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var calendarViewHeight: NSLayoutConstraint!
    
    var currentPage: Date?
    var today: Date = Date()
    var dateFormatter: DateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setCalendar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    private func scrollCurrentPage(isPrev: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = isPrev ? -1 : 1
        self.currentPage = cal.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.calendarView.setCurrentPage(self.currentPage!, animated: true)
        
    }
    
    func configUI() {
        self.navigationController?.navigationBar.isHidden = true
        calendarBaseView.layer.cornerRadius = 20
        makeShadow(calendarBaseView)
        calendarBGView.layer.cornerRadius = 20
        
    }
    
    @IBAction func prevMonthButtonAction(_ sender: Any) {
        scrollCurrentPage(isPrev: true)
    }
    
    @IBAction func nextMonthButtonAction(_ sender: Any) {
        scrollCurrentPage(isPrev: false)
    }
    
    @IBAction func changeCalendarScopeButtonAction(_ sender: Any) {
        if calendarView.scope == .month {
            calendarView.scope = .week
            UIView.animate(withDuration: 0, animations: {
                self.calendarViewHeight?.constant = self.calendarView.frame.height / 6 + 20
                self.view.layoutIfNeeded()
            }, completion: nil)
        } else {
            calendarView.scope = .month
            
            UIView.animate(withDuration: 0, animations: {
                self.calendarViewHeight?.constant = 300
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
}


extension CalendarViewController: FSCalendarDelegate {
    func setCalendar() {
        dateFormatter.dateFormat = "M월"
        
        calendarView.delegate = self
        calendarView.headerHeight = 0
        calendarView.backgroundColor = .clear
        calendarView.scope = .month
        calendarView.appearance.weekdayTextColor = UIColor.black
        calendarView.appearance.todayColor = .white
        calendarView.appearance.titleTodayColor = .black
        calendarView.appearance.selectionColor = UIColor.FailyColor.mainPinkColor
        calendarView.appearance.todaySelectionColor = UIColor.FailyColor.secondaryPinkColor
        calendarView.appearance.titleSelectionColor = .black
        calendarHeadLabel.text = self.dateFormatter.string(from: calendarView.currentPage)
        self.calendarViewHeight?.constant = 300
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        self.calendarHeadLabel.text = self.dateFormatter.string(from: calendar.currentPage)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 선택됨")
        //별도 데이터 포맷을 생성하여 api 메소드 추가 필요
    }
    
}
