//
//  AllQuestionResponse.swift
//  Faily
//
//  Created by 구본의 on 2021/10/17.
//

import Foundation

struct AllQuestionResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: AllQuestionDetail?
}

struct AllQuestionDetail: Decodable {
    let question: String
    let isAnswered: Bool
    let allAnswered: Bool
    let answerInfo: [AnswerInfo]
}

struct AnswerInfo: Decodable {
    var user_name: String
    var answer: String
    var answer_date: String
}
