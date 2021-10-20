//
//  GetScheduleResponse.swift
//  Faily
//
//  Created by 구본의 on 2021/10/21.
//

import Foundation

struct GetScheduleResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let calendar: [ScheduleDetail]?
}

struct ScheduleDetail: Decodable {
    let calendar_date: String
    let calendar_category: String
    let calendar_name: String
    let calendar_place: String
    let calendar_memo: String
    let calendar_start_time: String
    let calendar_end_time: String
}
