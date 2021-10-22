//
//  AddScheduleService.swift
//  Faily
//
//  Created by 구본의 on 2021/10/23.
//

import Foundation

class AddscheduleService {
    let repository: AddScheduleRepository = AddScheduleRepository()
    
    func postAddSchedule(_ parameters: AddScheduleRequest, onCompleted: @escaping (AddScheduleResponse) -> Void, onError: @escaping (String) -> Void) {
        repository.postAddSchedule(parameters, onCompleted: { response in
            let responseData = AddScheduleResponse(isSuccess: response.isSuccess, code: response.code, message: response.message, calendar: response.calendar)
            onCompleted(responseData)
        }, onError: onError)
    }
}
