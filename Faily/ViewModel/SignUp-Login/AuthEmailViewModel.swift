//
//  AuthEmailViewModel.swift
//  Faily
//
//  Created by 구본의 on 2021/09/30.
//

import Foundation

class AuthEmailViewModel {
    weak var authEmailView: AuthEmailViewController?
    let useService = AuthEmailService()
    var showAlert: (_ message: String) -> Void = {_ in}
    
    func postAuthEmail(_ parameters: AuthEmailRequest) {
        useService.postAuthEmail(parameters, onCompleted: {[weak self] response in
            guard let self = self else {return}
            let message = response.message
            let code = response.code
            
            if response.isSuccess == true {
                print("인증번호가 발송되었습니다. 발송된 인증번호: \(response.VerificationCode)")
                self.authEmailView?.getAuthEmailNum = response.VerificationCode
            } else {
                print("\(code) Error")
                self.showAlert(message)
            }
            
        }, onError: { error in
            print("authEmailViewModel - \(error)")
            
        })
    }
}
