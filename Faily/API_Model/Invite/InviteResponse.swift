//
//  InviteResponse.swift
//  Faily
//
//  Created by 구본의 on 2021/10/01.
//

import Foundation

struct InviteResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let GroupCode: String?
}
