//
//  GetAllEmoticonService.swift
//  Faily
//
//  Created by 구본의 on 2021/11/01.
//

import Foundation

class GetAllEmoticonService {
    let repository: GetAllEmoticonRepository = GetAllEmoticonRepository()
    func getAllEmoticon(onCompleted: @escaping(GetAllEmoticonResponse) -> Void, onError: @escaping(String) -> Void) {
        repository.getAllEmoticon(onCompleted: {response in
            let responseData = GetAllEmoticonResponse(isSuccess: response.isSuccess, code: response.code, message: response.message, result: response.result)
            onCompleted(responseData)
        }, onError: {error in
            onError(error)
        })
    }
}
