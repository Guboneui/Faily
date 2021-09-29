//
//  LoginViewModel.swift
//  Faily
//
//  Created by 구본의 on 2021/09/30.
//

import Foundation

class LoginViewModel {
    weak var loginView: LoginViewController?
    let useService = LoginService()
    var goAlertView: () -> Void = {}
    var showAlert: (_ message: String) -> Void = {_ in}
    
    func postLogin(_ parameters: LoginRequest) {
        useService.postLogin(parameters, onCompleted: { [weak self] response in
            guard let self = self else {return}
            let message = response.message
            let code = response.code
            
            if response.isSuccess == true {
                print("로그인에 성공하였습니다. 알림 권한 허용 화면으로 이동합니다.")
                print("jwtToken이 디바이스에 저장됩니다.")
                UserDefaults.standard.set(response.jwt_token, forKey: UserDefaultKey.jwtToken)
                self.goAlertView()
            } else {
                print("\(code) Error")
                self.showAlert(message)
            }
        }, onError: {error in
            print("loginViewModel - \(error)")
        })
    }
}
