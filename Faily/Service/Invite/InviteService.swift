//
//  InviteService.swift
//  Faily
//
//  Created by 구본의 on 2021/10/01.
//

import Foundation

class InviteService {
    let repository: InviteRepository = InviteRepository()
    
    func postGroupCode(_ parameters: InviteRequest, onCompleted: @escaping (InviteResponse) -> Void, onError: @escaping (String) -> Void) {
        repository.postGroupCode(parameters, onCompleted: { response in
            let responseData = InviteResponse(isSuccess: response.isSuccess, code: response.code, message: response.message, GroupCode: response.GroupCode)
            onCompleted(responseData)
        }, onError: onError)
    }
}
