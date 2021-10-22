//
//  SendAnswerResponse.swift
//  Faily
//
//  Created by 구본의 on 2021/10/23.
//

import Foundation

struct SendAnswerResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
