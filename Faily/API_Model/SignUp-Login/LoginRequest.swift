//
//  LoginRequest.swift
//  Faily
//
//  Created by 구본의 on 2021/09/30.
//

import Foundation

struct LoginRequest: Encodable {
    let user_email: String
    let user_pw: String
}
