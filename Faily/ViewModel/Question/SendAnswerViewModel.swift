//
//  SendAnswerViewModel.swift
//  Faily
//
//  Created by 구본의 on 2021/10/23.
//

import Foundation

class SendAnswerViewModel {
    let useService: SendAnswerService = SendAnswerService()
    weak var qaView: QAViewController?
    var dismissView: () -> Void = {}
    
    func postSendAnswer(_ parameters: SendAnswerRequest) {
        useService.postSendAnswer(parameters, onCompleted: {[weak self] response in
            guard let self = self else {return}
            let code = response.code
            let message = response.message
            
            if response.isSuccess == true {
                print("답변을 성공적으로 전달했습니다.")
                HomeViewController.userInfo[1].userFamiliar = 92.975
                self.dismissView()
            } else {
                print("\(code): \(message)")
            }
        }, onError: {error in
            print(error)
        })
    }
}

