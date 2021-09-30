//
//  AuthEmailService.swift
//  Faily
//
//  Created by 구본의 on 2021/09/30.
//

import Foundation

class AuthEmailService {
    let repository: AuthEmailRepository = AuthEmailRepository()
    
    func postAuthEmail(_ parameters: AuthEmailRequest, onCompleted: @escaping (AuthEmailResponse) -> Void, onError: @escaping (String) -> Void) {
        repository.postAuthEmail(parameters, onCompleted: { response in
            let responseData = AuthEmailResponse(isSuccess: response.isSuccess, code: response.code, message: response.message, VerificationCode: response.VerificationCode)
            onCompleted(responseData)
            
        }, onError: onError)
    }
}
