//
//  AddScheduleResponse.swift
//  Faily
//
//  Created by 구본의 on 2021/10/23.
//

import Foundation

struct AddScheduleResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var calendar: CheckCalendarDetail?
}

struct CheckCalendarDetail: Decodable {
    var calendar_date: String
    var calendar_category: String
    var calendar_name: String
    var calendar_place: String
    var calendar_memo: String
    var calendar_start_time: String
    var calendar_end_time: String
}
