//
//  GetAllScheduleViewModel.swift
//  Faily
//
//  Created by 구본의 on 2021/10/21.
//

import Foundation

class GetAllScheduleViewModel {
    weak var calendarView: CalendarViewController?
    let useService = GetAllScheduleService()
    var reloadTableView: () -> Void = {}
    
    var detailSchedule: [ScheduleDetail] = [] {
        didSet {
            calendarView?.mainTableView.reloadData()
        }
    }
    
    
    func getAllSchedule() {
        useService.getAllSchedule(onCompleted: {[weak self] response in
            guard let self = self else {return}
            let code = response.code
            let message = response.message
            if response.isSuccess == true {
                print("일정을 불러왔습니다.")
                self.detailSchedule = response.calendar!
                self.reloadTableView()
            } else {
                print("\(code): \(message)")
            }
        }, onError: {error in
            print("scheduleViewModel - \(error)")
        })
    }
}
