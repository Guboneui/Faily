//
//  LoginService.swift
//  Faily
//
//  Created by 구본의 on 2021/09/30.
//

import Foundation

class LoginService {
    let repository: LoginRepository = LoginRepository()
    
    func postLogin(_ parameters: LoginRequest, onCompleted: @escaping (LoginResponse) -> Void, onError: @escaping (String) -> Void) {
        repository.postLogin(parameters, onCompleted: { response in
            let responseData = LoginResponse(isSuccess: response.isSuccess, code: response.code, message: response.message, jwt_token: response.jwt_token)
            onCompleted(responseData)
        }, onError: onError)
    }
}
