//
//  InviteViewModel.swift
//  Faily
//
//  Created by 구본의 on 2021/10/01.
//

import Foundation

class InviteViewModel {
    weak var inviteView: FounderViewController?
    let useService = InviteService()
    var showCodeLabel: (_ code: String) -> Void = {_ in}
    var showAlert: (_ message: String) -> Void = {_ in}
    
    func postGroupCode(_ parameters: InviteRequest) {
        useService.postGroupCode(parameters, onCompleted: { [weak self] response in
            guard let self = self else {return}
            let message = response.message
            let code = response.code
            
            if response.isSuccess == true {
                print("채팅방 코드가 발급되었습니다. 코드는 <\(String(describing: response.GroupCode))>입니다.")
                UserDefaults.standard.set(true, forKey: UserDefaultKey.createdGroupCode)
                self.showAlert(message)
                UserDefaults.standard.set(response.GroupCode, forKey: UserDefaultKey.groupCode)
                DispatchQueue.main.async {
                    let code = UserDefaults.standard.string(forKey: UserDefaultKey.groupCode)
                    self.showCodeLabel(code ?? "코드 발급 중")
                }
            } else {
                print("\(code) Error")
                self.showAlert(message)
            }
        }, onError: {error in
            print("InviteViewModel - \(error)")
        })
    }
}
