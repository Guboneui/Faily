//
//  SignUpViewModel.swift
//  Faily
//
//  Created by 구본의 on 2021/09/28.
//

import Foundation

class SignUpViewModel {
    weak var signUpView: SignUpViewController?
    let useSerVice = SignUpService()
    var goAuthEmailView: () -> Void = {}
    var showAlert: (_ message: String) -> Void = {_ in}
    
    
    func postSignUp(_ parameters: SignUpRequest) {
        useSerVice.postSignUp(parameters, onCompleted: {[weak self] response in
            guard let self = self else {return}
            let message = response.message
            let code = response.code
            
            if response.isSuccess == true {
                print("이메일 인증 화면으로 이동합니다")
                print("jwtToken이 디바이스에 저장됩니다.")
                UserDefaults.standard.set(response.jwt_token, forKey: UserDefaultKey.jwtToken)
                self.goAuthEmailView()
            } else {
                print("\(code) Error")
                self.showAlert(message)
            }
        }, onError: {error in
            print("signUpViewModel - \(error)")
        })
    }
}
