//
//  PostMakeEmoticonService.swift
//  Faily
//
//  Created by 구본의 on 2021/11/01.
//

import Foundation

class PostMakeEmoticonService {
    let repository: PostMakeEmoticonRepository = PostMakeEmoticonRepository()
    func postMakeEmoticon(_ parameters: PostMakeEmoticonRequest, onCompleted: @escaping (PostMakeEmoticonResponse) -> Void, onError: @escaping (String) -> Void) {
        repository.postMakeEmoticon(parameters, onCompleted: { response in
            let responseData = PostMakeEmoticonResponse(isSuccess: response.isSuccess, code: response.code, message: response.message)
            onCompleted(responseData)
        }, onError: {error in
            onError(error)
        })
    }
}
