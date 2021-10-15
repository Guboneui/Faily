//
//  LoginResponse.swift
//  Faily
//
//  Created by 구본의 on 2021/09/30.
//

import Foundation

struct LoginResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let jwt_token: String?
    let group_code: String?
}
