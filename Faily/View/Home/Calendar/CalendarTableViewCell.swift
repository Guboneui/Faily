//
//  CalendarTableViewCell.swift
//  Faily
//
//  Created by 구본의 on 2021/09/23.
//

import UIKit
import FSCalendar
import PanModal

class CalendarTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var calendarBaseView: UIView!
    @IBOutlet weak var calendarBGView: UIImageView!
    @IBOutlet weak var calendarTitleLabel: UILabel!
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var addDateButton: UIButton!
    
    var currentPage: Date = Date()
    var today: Date = Date()
    var dateFormatter: DateFormatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCalendar()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configUI() {
        calendarBaseView.layer.cornerRadius = 20
        calendarBGView.layer.cornerRadius = 20
        makeShadow(calendarBaseView)
    }
    func makeShadow(_ view: UIView) {
        view.layer.shadowColor = UIColor.FailyColor.grayscale_4.cgColor
        view.layer.shadowOpacity = 0.33
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    func scrollCurrentPage(isPrev: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = isPrev ? -1 : 1
        self.currentPage = cal.date(byAdding: dateComponents, to: self.currentPage )!
        self.calendarView.setCurrentPage(self.currentPage, animated: true)
        
    }
    
    @IBAction func prevMonthButtonAction(_ sender: Any) {
        scrollCurrentPage(isPrev: true)
    }
    
    @IBAction func nextMonthButtonAction(_ sender: Any) {
        scrollCurrentPage(isPrev: false)
    }
 
}

extension CalendarTableViewCell: FSCalendarDelegate {
    func setCalendar() {
        dateFormatter.dateFormat = "YYYY년 M월"
        calendarView.delegate = self
        calendarView.headerHeight = 0
        calendarView.scope = .month
        calendarView.appearance.weekdayTextColor = UIColor.black
        calendarView.backgroundColor = .clear
        calendarView.appearance.todayColor = .clear
        calendarView.appearance.titleTodayColor = UIColor.FailyColor.mainPinkColor
        calendarView.appearance.selectionColor = UIColor.FailyColor.secondaryPinkColor
        //calendarView.appearance.todaySelectionColor = UIColor.FailyColor.secondaryPinkColor
        calendarView.appearance.titleSelectionColor = .white
        calendarTitleLabel.text = self.dateFormatter.string(from: calendarView.currentPage)
        
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        self.calendarTitleLabel.text = self.dateFormatter.string(from: calendar.currentPage)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 선택됨")
        //별도 데이터 포맷을 생성하여 api 메소드 추가 필요
    }
    
}

