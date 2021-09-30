//
//  SignUpService.swift
//  Faily
//
//  Created by 구본의 on 2021/09/28.
//

import Foundation

class SignUpService {
    let repository: SignUpRepository = SignUpRepository()
    
    func postSignUp(_ parameters: SignUpRequest, onCompleted: @escaping (SignUpResponse) -> Void, onError: @escaping (String) -> Void) {
        repository.postSignUp(parameters, onCompleted: { response in
            let responseData = SignUpResponse(isSuccess: response.isSuccess, code: response.code, message: response.message, jwt_token: response.jwt_token)
            onCompleted(responseData)
            
        }, onError: onError)
    }
}
