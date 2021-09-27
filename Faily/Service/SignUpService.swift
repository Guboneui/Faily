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
        repository.postSignUp(parameters, onCompleted: {[weak self] response in
            let requestData = SignUpResponse(result: response.result, code: response.code, message: response.message)
            onCompleted(requestData)
            
        }, onError: onError)
    }
}
