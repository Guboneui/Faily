//
//  AddScheduleViewModel.swift
//  Faily
//
//  Created by 구본의 on 2021/10/23.
//

import Foundation

class AddScheduleViewModel {
    weak var addScheduleView: AddDateViewController?
    let useService = AddscheduleService()
    var successAddSchedule: () -> Void = {}
    func postAddSchedule(_ parameters: AddScheduleRequest) {
        useService.postAddSchedule(parameters, onCompleted: {[weak self] response in
            guard let self = self else {return}
            let message = response.message
            let code = response.code
            
            if response.isSuccess == true {
                print("일정을 추가하였습니다.")
                
                self.successAddSchedule()
            } else {
                print("일정 추가에 실패하였습니다.")
                print("code: \(code) - message: \(message)")
            }
        }, onError: {error in
            print("\(error)")
        })
    }
}
