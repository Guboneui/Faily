//
//  SendAnswerRequest.swift
//  Faily
//
//  Created by 구본의 on 2021/10/23.
//

import Foundation

struct SendAnswerRequest: Encodable {
    var answer: String
    var question_index: Int
}
