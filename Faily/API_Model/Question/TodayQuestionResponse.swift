//
//  TodayQuestionResponse.swift
//  Faily
//
//  Created by 구본의 on 2021/10/03.
//

import Foundation

struct TodayQuestionResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var todayQuestion: String?
}
