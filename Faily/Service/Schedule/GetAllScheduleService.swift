//
//  GetAllScheduleService.swift
//  Faily
//
//  Created by 구본의 on 2021/10/21.
//

import Foundation

class GetAllScheduleService {
    let repository: GetAllScheduleRepository = GetAllScheduleRepository()
    
    func getAllSchedule(onCompleted: @escaping (GetScheduleResponse) -> Void, onError: @escaping (String) -> Void) {
        repository.getAllSchedule(onCompleted: {response in
            let responseData = GetScheduleResponse(isSuccess: response.isSuccess, code: response.code, message: response.message, calendar: response.calendar)
            onCompleted(responseData)
        }, onError: onError)
    }
}
